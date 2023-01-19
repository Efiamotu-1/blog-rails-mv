class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments

  after_save :update_post_counter

  def five_recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_post_counter
    user.increment!(:post_counter)
  end
end
