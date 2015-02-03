class OrderNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

  def ship_date_changed(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Shipping Date Changed'
  end

  def sys_admin_mail(error)
    @error = error
    mail to:"skyamgar@gmail.com", subject: 'Error'
  end
end
