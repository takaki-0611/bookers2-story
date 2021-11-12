class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.timestamps
      t.float :rate, null: false, defaut: 0
    end
  end
end
