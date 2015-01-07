class ProductsController < ApplicationController
   #before_filter :check_logged_in, :only=>[:edit, :update, :destroy]

  def index
    @products= Product.all
  end

  def show
    @product = Product.find(params[:id])
    puts @product
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.create(set_params)
    redirect_to "/products/#{@product.id}"
  end

  def new
    @product = Product.new
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(set_params)
    redirect_to product_path
  end

  def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end


private

def set_params
  params.require(:product).permit(:title, :description, :image_url, :price)
end

end