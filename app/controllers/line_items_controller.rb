class LineItemsController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:create, :destroy, :show, :edit]
	skip_before_action :authorize, only: :create

	def create
    product = Product.find(params[:product_id])
		@line_item = @cart.add_product(product.id)

		respond_to do |format|
			if @line_item.save
				format.html { redirect_to store_url, notice: 'Line item was successfully created.' }
				format.js { @current_item = @line_item }
				format.json { render action: 'show',status: :created, location: @line_item }
			else
				format.html { render action: 'new' }
				format.json { render json: @line_item.errors,status: :unprocessable_entity }
			end
			session[:counter] = 1
		end

	end

	# def show
 #    @line_item = LineItem.find(params[:id])
 #  end

 #  def edit
 #    @line_item = LineItem.find(params[:id])
 #  end

	# def update
 #    @line_item = LineItem.find(params[:id])
 #    @line_item.update(line_item_params)
 #    redirect_to "/lineitems/#{@line_item.id}"
 #  end

  def destroy
  	@line_item = LineItem.find(params[:id])

  	if @line_item.quantity <= 1
  		 @line_item.destroy
  	else
  		@line_item.quantity -= 1
  	end
  	respond_to do |format|

      if @line_item.save
				format.html { redirect_to store_url, notice: 'Line item was successfully created.' }
				format.js
				format.json { render action: 'show',status: :created, location: @line_item }
			else
				format.html { render action: 'new' }
				format.json { render json: @line_item.errors,status: :unprocessable_entity }

			end
		end
	end

	def line_item_params
		params.require(:line_item).permit(:product_id)
	end

end
