class AddAdminFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :birthday, :date
    add_column :users, :avatar_id, :integer
    add_column :users, :passport_id, :integer
    add_column :users, :admin, :boolean
  end
end
