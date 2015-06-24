class RenameTraitsToProperties < ActiveRecord::Migration
  def change
    rename_table :traits, :properties
  end
end
