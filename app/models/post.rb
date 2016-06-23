class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic
  default_scope { order('created_at DESC')}

  validates :title, length: {minimum: 5, message:"Title has to be minimum 5 characters"}
  validates :body, length: {minimum: 20}
  validates :topic, presence: true
  validates :user, presence: true
end
