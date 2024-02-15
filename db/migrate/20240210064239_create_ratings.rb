class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
