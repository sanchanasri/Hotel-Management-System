class Rating < ApplicationRecord
  belongs_to :hotel
  belongs_to :item
  belongs_to :user
  validates :value, presence: true
  validates :item_id, uniqueness: {scope: :user_id , message: "You can only rate once"}

  after_save :update_average_count

  def update_average_count
    item.update_average
  end
end
