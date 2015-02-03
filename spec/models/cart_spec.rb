require 'rails_helper'

describe Cart do
  describe "associations" do
       it { should have_many :line_items }
  end

  describe "#add product" do
    it "should add line_item for given product" do
      cart = create :cart
      product = create :product
      expect(cart.add_product(product.id)).to be_an_instance_of(LineItem)
    end

    it "should add line_item for given product" do
      cart = create :cart
      product = create :product
      line_item = create :line_item, cart: cart, product: product
      current_line_item = cart.add_product(product.id)
      expect(current_line_item.quantity).to eq(2)
    end
  end
end
