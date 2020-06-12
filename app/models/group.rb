class Group < ApplicationRecord
    has_many :post_groups
    has_many :posts, through: :post_groups
    has_many :user_groups
    has_many :users, through: :user_groups
end
