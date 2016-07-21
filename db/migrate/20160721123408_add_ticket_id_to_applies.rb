class AddTicketIdToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :ticket_id, :integer
  end
end
