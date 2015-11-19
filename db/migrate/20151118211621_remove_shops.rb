class RemoveShops < ActiveRecord::Migration
  def up
    drop_table :shops
  end

  def down
    create_table :shops do |t|
      t.string :name
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
