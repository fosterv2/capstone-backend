class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :post_img
      t.integer :likes
      t.integer :user_id

      t.timestamps
    end
  end
end
