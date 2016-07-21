class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :number
      t.integer :user_id
      t.string :is_used,:default => "未使用"
      t.string :ticket_tips

      t.timestamps
    end
  end
end
