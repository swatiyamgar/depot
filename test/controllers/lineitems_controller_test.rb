require 'test_helper'

class LineitemsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create line_item" do
		assert_difference('LineItem.count', 1) do
			post :create, product_id: products(:ruby).id
		end
		assert_redirected_to cart_path(assigns(:line_item))
	end
		
	
		test "should update line_item" do
			byebug
			@line_item=LineItem.create(cart_id: 11, product_id: 31)
			patch	:update, id: @line_item, line_item: { product_id: @line_item.product_id }
			byebug
			assert_redirected_to lineitem_path(assigns(:line_item))
	end
end
