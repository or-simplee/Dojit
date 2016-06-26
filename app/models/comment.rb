class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: {minimum: 5, message:"has to be at least 5 characters"}
  validates :post, presence: true
  validates :user, presence: true
end
