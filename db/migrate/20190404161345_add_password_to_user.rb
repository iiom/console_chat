class AddPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
  end
end
