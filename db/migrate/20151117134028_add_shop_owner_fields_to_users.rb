class AddShopOwnerFieldsToUsers < ActiveRecord::Migration
  def change
    add_belongs_to :users, :shop, index: true
    add_column     :users, :shop_owner, :boolean
  end
end
