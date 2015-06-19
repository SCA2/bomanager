class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.string  :name
      t.string  :value
      t.integer :component_id
    end
    add_index   :traits, :component_id
  end
end
