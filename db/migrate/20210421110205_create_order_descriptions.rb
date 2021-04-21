class CreateOrderDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :order_descriptions do |t|
      t.integer :quantity
      t.references :item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
