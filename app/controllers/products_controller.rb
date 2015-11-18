class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if can? :see_pro_ones, Product
      visible_products = Product.all
    else
      visible_products = Product.where(pro: false)
    end
    @products = visible_products.paginate(page: params[:page], per_page: 10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @product.build_photo
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = 'Создан новый продукт'
      redirect_to products_path
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

    authorize! :make_pro, @product if params[:product][:pro] != @product.pro

    if @product.update(product_params)
      flash[:success] = 'Изменение продукта прошло успешно'
      redirect_to products_path
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
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :pro,
                                    photo_attributes: [:image, :title, :id,
                                                       :remove_image])
  end
end
