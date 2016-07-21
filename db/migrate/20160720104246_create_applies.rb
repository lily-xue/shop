class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.string :status,default: "申请"
      t.datetime :overtime
      t.string :tips

      t.timestamps
    end
  end
end
