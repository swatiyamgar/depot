require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  	fixtures :products
  	fixtures :orders
	test "requires item in cart" do
		get :new
		assert_redirected_to store_path
		assert_equal flash[:notice], 'Your cart is empty'
	end

	test "should get new" do
		item = LineItem.new
		item.build_cart
		item.product = products(:ruby)
		item.save!
		session[:cart_id] = item.cart.id
		get :new
		assert_response :success
	end

	test "should create order" do
		@order = Order.create(name: "swati", address: "asdfr", email: "sky@gmail.com", payment_id: 1)
		assert_difference('Order.count',1) do
			post :create, order: { address: @order.address, email: @order.email,
			name: @order.name, payment_id: @order.payment_id }
		end
		assert_redirected_to store_path
	end
end
