class CreateBorrowRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :borrow_requests do |t|
      t.date :borrowed_date
      t.date :return_date
      t.date :actual_return_date
      t.integer :status
      t.references :user, null: true, foreign_key: true
      t.references :book, null: true, foreign_key: true

      t.timestamps
    end
  end
end
