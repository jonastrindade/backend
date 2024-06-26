class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.datetime :deleted_at, null: true

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
