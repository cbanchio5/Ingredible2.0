class Community < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_one_attached :photo
end