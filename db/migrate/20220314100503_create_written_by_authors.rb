class CreateWrittenByAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :written_by_authors do |t|
      t.references :author, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
