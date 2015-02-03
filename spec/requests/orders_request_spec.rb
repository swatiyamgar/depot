require 'rails_helper'
describe "Order Management" do
  it "buying a product" do
    sign_in
    product = create :product
    payment = create :payment
    visit store_url
    expect{
       click_button 'Add to Cart'
    }.to change(LineItem, :count).by(1)
    click_button 'Checkout'
    expect(current_path).to eq "/en/orders/new"

    fill_in 'Name', with: 'Swati'
    fill_in 'Address', with: 'abdcfe'
    fill_in 'E-mail', with: 'skyamgar@gmail.com'
    select 'Check', from: 'order_payment_id'
    click_button 'Place Order'

    expect(current_path).to eq store_path(locale: :en)
    expect(page).to have_content "Thank you for your order"

  end
end
