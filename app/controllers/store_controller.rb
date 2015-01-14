class StoreController < ApplicationController

	def incerement_counter
		if session[:counter].nil?
    		session[:counter] = 0
  		end
  	session[:counter] += 1
	end
  def index
  	@count = incerement_counter
  	@products=Product.order(:title)
  end
end
