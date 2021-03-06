class User < ActiveRecord::Base

  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :moderated_subs,
  class_name: "Sub",
  foreign_key: :moderator_id,
  primary_key: :id

  has_many :posts,
  class_name: "Post",
  foreign_key: :author_id,
  primary_key: :id

  has_many :comments,
  class_name: "User",
  foreign_key: :author_id,
  primary_key: :id

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user && user.is_password?(password) ? user : nil
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
