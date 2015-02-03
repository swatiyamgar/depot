FactoryGirl.define do
	factory :order do
    association :payment
		name "swati"
		email { Faker::Internet.email }
		address "aascjnn"

    factory :invalid_order do
      association :payment
      name "swati"
      email { Faker::Internet.email }
      address nil
    end
	end
end
