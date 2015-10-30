class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = 'Создан новый продукт'
      redirect_to admin_products_path
    else
      render 'new'
    end
  end

  def destroy
    if Product.find(params[:id]).destroy
      flash[:danger] = 'Продукт успешно удален'
    else
      flash[:danger] = 'Не удалось удалить продукт'
    end
    redirect_to admin_products_path
  end

  private
    def product_params
      params.require(:product).permit(:title, :description)
    end
end
