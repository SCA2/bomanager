class CreateBoms < ActiveRecord::Migration
  def change
    create_table :boms do |t|
      t.timestamps
      t.string :name
      t.integer :user_id
    end
    add_index :boms, :user_id  end
end
