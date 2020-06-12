class Post < ApplicationRecord
    belongs_to :user
    has_many :post_groups
    has_many :groups, through: :post_groups
    has_many :likes
    has_many :comments
end
