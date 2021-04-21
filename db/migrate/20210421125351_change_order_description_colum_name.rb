class ChangeOrderDescriptionColumName < ActiveRecord::Migration[6.1]
  def change
    rename_column :order_descriptions, :qantity, :quantity
  end
end
