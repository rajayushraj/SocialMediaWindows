class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
    	t.text :description
      t.references :user ,null: false,foreign_key: true
      t.integer :comments_count ,default: 0
      t.integer :likes_count ,default: 0

      t.timestamps
    end
  end
end
