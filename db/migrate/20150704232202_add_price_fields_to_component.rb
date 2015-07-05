class AddPriceFieldsToComponent < ActiveRecord::Migration
  def change
    add_column :components, :price, :decimal, precision: 10, scale: 4
    add_column :components, :distributor, :string
    add_column :components, :last_priced, :datetime
  end
end
