class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_link
      t.integer :inventory
      t.string :description
      t.integer :current_price
      t.boolean :enabled, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
