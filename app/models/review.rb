class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: (1..5), message: "must be from 1 to 5."  }
end