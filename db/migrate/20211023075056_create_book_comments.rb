class CreateBookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :book_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :book_id
      t.float :rate, null: false, defaut: 0
      t.timestamps
    end
  end
end
