class OrdersController < ApplicationController
	include CurrentCart
	before_action :set_cart, only:[:new, :create]
	skip_before_action :authorize, only: [:new, :create]

	def new
		if @cart.line_items.empty?
			redirect_to store_url, notice: "Your cart is empty"
			return
		else
			@order=Order.new
		end
		#redirect_to store_url
	end

	def show
	end

	def create
		@order = Order.new(order_params)
		@order.add_line_items_from_cart(@cart)
		respond_to do |format|
			if @order.save

				Cart.destroy(session[:cart_id])
				session[:cart_id] = nil
				OrderNotifier.received(@order).deliver_now
				OrderNotifier.shipped(@order).deliver_now
				@order.update(ship_date: (Time.now + 4.day))

				format.html {redirect_to store_url, notice: I18n.t('.thanks')}
				format.json {render action: 'show', status: :created, location: @order}
			else
				format.html { render action: 'new' }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	def latest_updates
	    #@product = Product.find(params[:id])
	    @latest_order = Order.all.order(:ship_date).last
	    #@val = @order.changed.include?("ship_date")
	    if stale?(@latest_order)
	      respond_to do |format|
	        format.html { render html: @product }
	        format.atom { render action: 'ship_date'}
	        format.json { render json: @product.to_json }
	        format.xml { render xml: @product.to_xml }
	      end
	    end
	end

	private
	def order_params
		params.require(:order).permit(:name, :address, :email, :payment_id)
	end
end
