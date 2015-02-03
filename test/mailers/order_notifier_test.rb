require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["skyamgar@gmail.com"], mail.from
    #mail.body = "1 x "
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["skyamgar@gmail.com"], mail.from
    mail.body = "1 x Programming Ruby 1.9"
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

end
