class RemoveTelephoneFromUsers < ActiveRecord::Migration
  def change
remove_column :users, :telephone, :string
  end
end
