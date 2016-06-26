class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic
  mount_uploader :image, ImageUploader
  default_scope { order('created_at DESC')}

  validates :title, length: {minimum: 5, message:"has to be at least 5 characters"}
  validates :body, length: {minimum: 20,message:"has to be at least 20 characters"}
  validates :topic, presence: true
  validates :user, presence: true
end
