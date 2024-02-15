class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :hotel, null: false, foreign_key: true
      t.string :name
      t.json :days
      t.json :times

      t.timestamps
    end
  end
end
