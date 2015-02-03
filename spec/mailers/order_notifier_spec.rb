require 'rails_helper'

describe OrderNotifier do
  let(:order) { create :order }
  it "should send email when order is created" do
    OrderNotifier.received(order).deliver_now
    expect(open_last_email).to be_delivered_to order.email
    expect(open_last_email).to have_subject 'Pragmatic Store Order Confirmation'
    expect(open_last_email).to be_delivered_from "Swati Yamgar <skyamgar@gmail.com>"
  end

  it "should send email when order is shipped" do
    OrderNotifier.shipped(order).deliver_now
    expect(open_last_email).to be_delivered_to order.email
    expect(open_last_email).to have_subject 'Pragmatic Store Order Shipped'
    expect(open_last_email).to be_delivered_from "Swati Yamgar <skyamgar@gmail.com>"
  end

  it "should send email when ship date is changed" do
    OrderNotifier.ship_date_changed(order).deliver_now
    expect(open_last_email).to be_delivered_to order.email
    expect(open_last_email).to have_subject 'Pragmatic Store Shipping Date Changed'
    expect(open_last_email).to be_delivered_from "Swati Yamgar <skyamgar@gmail.com>"
  end
end
