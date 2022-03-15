class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: {unique: true, name: "unique_email"}
      t.date :birthday
      t.string :address
      t.string :phone
      t.string :id_card
      t.integer :role
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_expired_at

      t.timestamps
    end
  end
end
