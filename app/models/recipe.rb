class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :difficulty, presence: true
  validates :time, presence: true
  validates :serves, presence: true
  validates :steps, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_and_ingredients,
    against: [ :name, :ingredients ],
    using: {
      tsearch: { prefix: true }
    }
 #scope :filter_by_difficulty, ->(tag_ids_arr) { joins(:tags).where( tags: { id: tag_ids_arr } ) }
end