class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      t.string :image_uid
      t.string :image_name
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
