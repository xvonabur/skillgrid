class AddShopNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shop_name, :string
  end
end
