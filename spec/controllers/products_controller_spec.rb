require 'rails_helper'
require 'devise_setup'

RSpec.describe ProductsController, type: :controller do
  it "doesn't allow not signed in user to delete a product" do
    product = create(:product)

    expect {
      delete(:destroy, id: product.id )
    }.not_to change { Product.count }
  end

  it "doesn't allow not signed in user to create a product" do
    expect {
      post(:create, product: { title: 'Name', description: 'Description' } )
    }.not_to change { Product.count }
  end

  it "doesn't allow not signed in user to update a product" do
    product = create(:product)

    expect {
      patch(:update, id: product.id, product: { title: 'Name1' })
    }.not_to change { product.reload.title }
  end

  it "doesn't allow guest to make product a pro" do
    @user = FactoryGirl.create(:guest)
    sign_in @user
    product = create(:product, { pro: false })

    expect {
      patch(:update, id: product.id, product: { pro: true })
    }.not_to change { product.reload.pro }
  end

  it "doesn't allow shop owner to make product a pro" do
    @user = FactoryGirl.create(:shop_owner)
    sign_in @user
    product = create(:product, { pro: false })

    expect {
      patch(:update, id: product.id, product: { pro: true })
    }.not_to change { product.reload.pro }
  end
end
