class AddReferenceToBomItems < ActiveRecord::Migration
  def change
    add_column :bom_items, :reference, :string
  end
end
