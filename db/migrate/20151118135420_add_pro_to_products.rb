class AddProToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pro, :boolean, default: false, null: false
  end
end
