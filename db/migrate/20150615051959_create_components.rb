class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.integer :category_id
    end
    add_index :components, :category_id
  end
end
