class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :product_id
      t.decimal :price, precision: 8, scale: 2
      t.string :size

      t.timestamps
    end
  end
end
