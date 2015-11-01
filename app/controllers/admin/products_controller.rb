class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.build_photo
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = 'Создан новый продукт'
      redirect_to admin_products_path
    else
      @product.build_photo
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @product.build_photo if @product.photo.nil?
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = 'Изменение продукта прошло успешно'
      redirect_to admin_products_path
    else
      render 'edit'
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
      params.require(:product).permit(:title, :description,
                                      photo_attributes: [:image, :title])
    end
end
