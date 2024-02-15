class Item < ApplicationRecord
  belongs_to :hotel
  has_many :ratings

  def ratings_count
    ratings.group(:value).count
  end

  def update_average
    update(average_rating: ratings.average(:value))
  end
end
