class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  mount_uploader :image, ImageUploader

  after_create :create_vote
  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    up_votes-down_votes
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  default_scope { order('rank DESC')}

  validates :title, length: {minimum: 5, message:"has to be at least 5 characters"}
  validates :body, length: {minimum: 20,message:"has to be at least 20 characters"}
  #validates :topic, presence: true
  #validates :user, presence: true

  private

  def create_vote
    user.votes.create(post: self, value: 1)
  end
end