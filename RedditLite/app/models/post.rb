class Post < ActiveRecord::Base

  validates :title, :author_id , presence: true

  belongs_to :sub

  belongs_to :author,
  class_name: "User",
  foreign_key: :author_id,
  primary_key: :id

  has_many :post_subs, inverse_of: :post

  has_many :subs, through: :post_subs, source: :sub

  has_many :comments

  has_many :top_level_comments,
  -> { where(parent_comment_id: nil) },
  class_name: "Comment",
  foreign_key: :post_id,
  primary_key: :id


  def comments_by_parent_id
    comms = {}

    self.comments.each do |comment|
      comms[comment.parent_comment_id] ||= []
      comms[comment.parent_comment_id] << comment
    end

    comms
  end


  # def subs=(subs)
#     self.sub_ids = subs.map(&:to_i)
#   end
#
end
