require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should destroy cart' do
	  assert_difference('Cart.count', -1) do
	  	@cart=Cart.create
	  	session[:cart_id] = @cart.id
	  	delete :destroy, id: @cart
	  end
	  assert_redirected_to store_path
	end
end
