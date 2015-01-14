class CartsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
	def index
    @carts= Cart.all
  end

  def show

    @cart = Cart.find(params[:id])    

  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(set_params)
    respond_to do |format|
     if @cart.save
        #format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @cart = Cart.new
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(set_params)
    redirect_to "/carts/#{@cart.id}"
  end

  def destroy
    @cart=Cart.find(session[:cart_id])
    @cart.destroy if @cart.id == session[:cart_id]
      session[:cart_id] = nil
      respond_to do |format|
        format.html { redirect_to store_url, notice: 'Your cart is currently empty' }
        format.json { head :no_content }
      end
    #redirect_to "/carts"
  end


private

def set_params
  params.require(:cart).permit
end

def invalid_cart
  logger.error "Attempt to access invalid cart #{params[:id]}"
  redirect_to store_url, notice: 'Invalid_cart'
end
end
