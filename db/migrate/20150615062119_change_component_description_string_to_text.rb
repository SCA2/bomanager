class ChangeComponentDescriptionStringToText < ActiveRecord::Migration
  def change
    change_column :components, :description, :text
  end
end
