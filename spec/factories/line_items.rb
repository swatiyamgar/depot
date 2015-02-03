FactoryGirl.define do
  factory :line_item do
    association :product
    association :cart
    association :order
    quantity 1
    price 123
  end
end
