class AddApplyIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :apply_id, :integer
  end
end
