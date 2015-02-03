FactoryGirl.define do
  factory :product do
    title  { Faker::Name.title }
    description "Having 2 GB RAM,Dual processor"
    image_url "cc.png"
    price 1
    locale "en"


    factory :invalid_product do
      title "john"
      description "Having 2 GB RAM,Dual processor"
      image_url "cc.png"
      price 1
      locale "en"
    end
  end
end
