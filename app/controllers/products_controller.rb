class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if can? :see_pro_ones, Product
      visible_products = Product.joins(:user)
                                .select('products.*, users.shop_name').all
    else
      visible_products = Product.joins(:user).where(pro: false)
                                .select('products.*, users.shop_name')
    end
    @products = visible_products.paginate(page: params[:page], per_page: 10)
  end

  def show
    @product = Product.joins(:user).where(id: params[:id])
                      .select('products.*, users.shop_name').first
  end

  def new
    @product = Product.new
    @product.build_photo
  end

  def create
    @product = Product.new(product_params)
    authorize! :create, @product

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
    authorize! :update, @product
    @product.build_photo if @product.photo.nil?
  end

  def update
    @product = Product.find(params[:id])
    @product.attributes = product_params
    product_changes = @product.changed

    if product_changes.any?
      if product_changes.include?('pro')
        authorize! :make_pro, @product
        product_changes.delete('pro')
      end
      if product_changes.any?
        authorize! :update, @product
      end
    end

    if @product.save
      flash[:success] = 'Изменение продукта прошло успешно'
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
    product = Product.find(params[:id])
    authorize! :delete, product

    if product.destroy
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
