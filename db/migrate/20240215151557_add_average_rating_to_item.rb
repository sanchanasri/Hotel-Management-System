class AddAverageRatingToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :average_rating, :float
  end
end
