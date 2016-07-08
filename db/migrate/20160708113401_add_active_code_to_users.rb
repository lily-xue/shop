class AddActiveCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ActiveCode, :string
  end
end
