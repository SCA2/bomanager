class CreateBomItem < ActiveRecord::Migration
  def change
    create_table :bom_items do |t|
      t.integer :quantity
      t.timestamps
    end
    add_reference :bom_items, :bom, index: true
    add_reference :bom_items, :component, index: true
  end
end
