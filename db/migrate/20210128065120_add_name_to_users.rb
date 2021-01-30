class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :acc_status, :integer,default: 0
  end
end
