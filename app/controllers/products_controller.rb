class ProductsController < ApplicationController
  #skip_before_action :authorize#, only: [:who_bought,:index]

  before_filter(only: :who_bought) do |controller|
    check_logged_in unless controller.request.format.html?
  end

  def index

    @cart = Cart.find_by(id: session[:cart_id])
    @products= Product.where(locale: I18n.locale.to_s)
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @cart = Cart.find_by(id: session[:cart_id])
    @product = Product.new(set_params)
    if set_params[:locale].to_i == 0
        @product.update(locale: 'es')
    else
        @product.update(locale: 'en')
    end
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
    @cart = Cart.find_by(id: session[:cart_id])
    @product = Product.new
  end

  def update
    @product = Product.find(params[:id])
    @product.update(set_params)
    if set_params[:locale].to_i == 0
        @product.update(locale: 'es')
    else
        @product.update(locale: 'en')
    end
   respond_to do |format|
     if @product.save

        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :edit}
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to "/products"
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.html { redirect_to @product }
        format.atom { render action: 'who_bought'}
        format.json { render json: @product.to_json }
        format.xml { render xml: @product.to_xml }
      end
    end
  end


  private

  def set_params
    params.require(:product).permit(:title, :description, :image_url, :price, :locale)
  end

  def check_logged_in
    authenticate_or_request_with_http_basic("Products") do |username,password|
      username == "admin" && password == "abc123"
    end
  end

end
