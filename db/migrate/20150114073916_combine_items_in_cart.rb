class CombineItemsInCart < ActiveRecord::Migration

  def up
  	Cart.all.each do |cart|
  		sums = cart.line_items.group(:product_id).sum(:quantity)

  		sums.each do |product_id, quantity|
  			if quantity > 1
  				cart.line_items.where(product_id: product_id).delete_all

  				item = cart.line_items.build(product_id: product_id)
  				item.quantity = quantity
  				item.save!
  			end
  		end
  	end
  end


  def down
  	# split items with quantity>1 into multiple items
  	LineItem.where("quantity > 1").each do |line_item|

    	# add individual items
    	line_item.quantity.times do

    		LineItem.create(
          cart: line_item.cart,
    		  product: line_item.product, 
          quantity: 1
        )
    	end

    	# remove original item
    	line_item.destroy
  	end
  end
end
