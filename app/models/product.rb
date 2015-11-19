class Product < ActiveRecord::Base
  has_one :photo
  belongs_to :user
  accepts_nested_attributes_for :photo
  validates_presence_of :title, :description, :price
  validates_presence_of :user
end
