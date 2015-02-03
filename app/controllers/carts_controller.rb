class CartsController < ApplicationController
  skip_before_action :authorize, only: [:create, :update, :destroy]
	def index
    @carts= Cart.all
  end

  def show
    @cart = Cart.find(params[:id])
  end

  # def edit
  #   @cart = Cart.find(params[:id])
  # end

  # def create
  #   @cart = Cart.new(set_params)
  #   respond_to do |format|
  #    if @cart.save
  #       #format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
  #       format.json { render :show, status: :created, location: @cart }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @cart.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   @cart = Cart.find(params[:id])
  #   @cart.update(set_params)
  #   redirect_to "/carts/#{@cart.id}"
  # end

  def destroy
    @cart=Cart.find(session[:cart_id])
    @cart.destroy if @cart.id == session[:cart_id]
      session[:cart_id] = nil
      respond_to do |format|
        format.html { redirect_to store_url}
        format.json { head :no_content }
      end
  end


  private
  def set_params
    params.require(:cart).permit
  end
end
