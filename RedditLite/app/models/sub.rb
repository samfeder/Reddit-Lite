class Sub < ActiveRecord::Base

  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
  class_name: "User",
  foreign_key: :moderator_id,
  primary_key: :id

  has_many :postsubs,
  class_name: "PostSub",
  foreign_key: :sub_id,
  primary_key: :id

  has_many :posts, through: :postsubs, source: :post

end
