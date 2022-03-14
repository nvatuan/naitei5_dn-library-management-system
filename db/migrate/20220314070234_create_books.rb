class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.integer :quantity
      t.date :published_date
      t.references :category, null: true, foreign_key: true
      t.references :publisher, null: true, foreign_key: true

      t.timestamps
    end
  end
end
