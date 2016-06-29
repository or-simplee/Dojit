class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  mount_uploader :image, ImageUploader

  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

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
  validates :topic, presence: true
  validates :user, presence: true

  def create_vote
    user.votes.create(post: self, value: 1)
  end

  def save_with_initial_vote
    ActiveRecord::Base.transaction do 
      self.save
      self.create_vote
    end
    self.present?
  end



end