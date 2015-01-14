class ProductsController < ApplicationController
   #before_filter :check_logged_in, :only=>[:edit, :update, :destroy]

  def index
    @products= Product.all
  end

  def show
    @product = Product.find(params[:id])    
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(set_params)
    respond_to do |format|
     if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @product = Product.new
  end

  def update
    @product = Product.find(params[:id])
    @product.update(set_params)
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to "/products"
  end


private

def set_params
  params.require(:product).permit(:title, :description, :image_url, :price)
end

end