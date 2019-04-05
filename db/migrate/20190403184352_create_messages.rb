class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :whom, default: nil
      t.references :user, index: true, foreign_key: true
      t.boolean :view, default: false

      t.timestamps
    end
  end
end
