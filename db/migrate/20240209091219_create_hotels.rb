class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :location
      t.string :contact_no
      t.json :days
      t.json :times

      t.timestamps
    end
  end
end
