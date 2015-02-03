class Order < ActiveRecord::Base
	#$order
	#attr_accessor :order
	has_many :line_items, dependent: :destroy
	#PAYMENT_TYPES = ["Check", "Credit card", "Purchase Order"]
	belongs_to :payment
	validates :name, :address, :email, presence: true

  after_update :send_notification_email

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end

	def send_notification_email
		if ship_date_changed?
			# email
			OrderNotifier.ship_date_changed(self).deliver_now
			#puts "Send notification email"
		end
		true
	end


end
