class Combinepaymentorder < ActiveRecord::Migration
  def up
  	add_column :orders, :payment_id, :integer
    Order.all.each do |order|
    	if order.pay_type
    		payment = Payment.find_by(pay_type: order.pay_type)
    		order.update(payment_id: payment.id)
    	end
    end
    remove_column :orders, :pay_type
  end

  def down 
  	add_column :order, :pay_type, :string
  	remove_column :orders, :payment_id
  end
end
