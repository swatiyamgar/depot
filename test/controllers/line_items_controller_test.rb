require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create line_item" do
		assert_difference('LineItem.count', 1) do
			post :create, product_id: products(:ruby).id
		end
		assert_redirected_to store_path
	end
		

  test "should create line_item via ajax" do
		assert_difference('LineItem.count') do
			xhr :post, :create, product_id: products(:ruby).id
		end
		assert_response :success
		assert_select_jquery :html, '#cart' do
			assert_select 'tr#current_item td', /Programming Ruby 1.9/
	end
end
	
  test "should update line_item" do		
		@line_item=LineItem.create(cart_id: 11, product_id: 31)
		patch	:update, id: @line_item, line_item: { product_id: @line_item.product_id }
		assert_redirected_to line_item_path(assigns(:line_item))
	end
end
