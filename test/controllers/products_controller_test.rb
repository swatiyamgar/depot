require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    
    assert_response :success
    assert_select '#banner'
    assert_select '.list_actions a', :minimum => 3
  end

  test "should get show" do
    product = Product.create(title: "test2645365435", description: "test desc", image_url: "ruby.png", price: 100)
    get :show, id: product.id
    assert_response :success
  end

  test "should get edit" do
    product = Product.create(title: "test1786868687", description: "test desc", image_url: "ruby.png", price: 100)
    get :edit, id: product.id
    assert_response :success
  end

  test "should get create" do
    product_attrs = { title: "test879987676768768", description: "test desc", image_url: "ruby.png", price: 100 }
    get :create, product: product_attrs
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
