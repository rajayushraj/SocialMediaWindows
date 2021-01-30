class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :sender ,null: false,foreign_key: {to_table: :users}
      t.references :receiver,null: false,foreign_key: {to_table: :users}
      t.boolean :status,default: false

      t.timestamps
    end
  end
end
