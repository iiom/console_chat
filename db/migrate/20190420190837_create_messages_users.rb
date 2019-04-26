class CreateMessagesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :messages_users do |t|
      t.references :user, foreign_key: true
      t.references :message, foreign_key: true
      t.string :whom, default: nil
      t.boolean :view, default: false

      t.timestamps
    end
  end
end
