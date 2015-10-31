require 'rails_helper'
require 'devise_setup'

RSpec.describe Admin::ProductsController, type: :controller do
  it "doesn't allow guest to delete a product" do
    product = create(:product)

    expect {
      delete(:destroy, id: product.id )
    }.not_to change { Product.count }
  end

  it "doesn't allow guest to create a product" do
    expect {
      post(:create, product: { title: 'Name', description: 'Description' } )
    }.not_to change { Product.count }
  end

  it "doesn't allow guest to update a product" do
    product = create(:product)

    expect {
      patch(:update, id: product.id, product: { title: 'Name1' })
    }.not_to change { product.reload.title }
  end
end
