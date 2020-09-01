class User < ApplicationRecord
    has_many :posts
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users
    has_many :user_groups
    has_many :groups, through: :user_groups
    has_many :likes
    has_many :messages
    has_many :users, through: :messages

    has_secure_password
    validates :username, uniqueness: true
end
