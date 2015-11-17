class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :image_uid
      t.string :image_name
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
