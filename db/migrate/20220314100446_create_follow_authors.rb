class CreateFollowAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_authors do |t|
      t.references :user, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
