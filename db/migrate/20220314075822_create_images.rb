class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :path
      t.references :imageable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
