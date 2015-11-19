class AddUserIdToProducts < ActiveRecord::Migration
  def change
    add_belongs_to :products, :user, index: true, foreign_key: true
  end
end
