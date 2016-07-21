class AddIsActivedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :IsActived, :bool
  end
end
