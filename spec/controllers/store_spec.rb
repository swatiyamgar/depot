require 'rails_helper'
describe StoreController do
  # describe "increment session counter" do
  #   it "session counter nil" do
  #     expect(session[:counter]).to eq(nil)
  #   end

  #   it "session counter present" do
  #     byebug
  #     @user = login_user
  #     expect(increment_counter).to eq(2)
  #   end
  # end

  describe 'GET #index' do
    it "show all products" do
     get :index , :set_locale =>"en"
     expect(response).to redirect_to store_url
    end
    it "show all products in other language" do
     get :index , :set_locale =>"es"
     expect(response).to redirect_to "/es"
    end
    it "renders the :index view" do
      get :index
      expect(assigns(:products).count).to eq(Product.count)
    end
  end
end
