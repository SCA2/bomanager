class AddManufacturerDescriptionImageToComponent < ActiveRecord::Migration
  def change
    add_column :components, :manufacturer, :string
    add_column :components, :description, :string
    add_column :components, :image_url, :string
  end
end
