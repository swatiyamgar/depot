require 'rails_helper'
describe LineItem do
    describe "Associations" do
         it { should belong_to :order }
         it { should belong_to :product}
         it { should belong_to :cart}
    end
end
