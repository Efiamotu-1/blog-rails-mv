class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  ROLES = %w[admin].freeze

  ROLES.each do |role_name|
    define_method "#{role_name}?" do
      role == role_name
    end
  end

  # def is?(requested_role)
  #   role == requested_role.to_s
  # end

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
