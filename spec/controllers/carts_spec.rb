require 'rails_helper'

describe CartsController do
  before { @user = login_user }

  describe 'GET #index' do
    it "populates an array of carts" do
     create_list :cart, 2
     get :index
     expect(assigns(:carts).count).to eq(2)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "shows requested cart to @cart" do
      cart = create :cart
      get :show, id: cart
      expect(assigns(:cart)).to eq(cart)
    end

    it "renders the :show template" do
      cart = create :cart
      get :show, id: cart
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    before do
      @cart = create :cart
      session[:cart_id] = @cart.id
    end

    it "delete the cart from database" do
      expect{
        delete :destroy, id: @cart
      }.to change(Cart, :count).by(-1)
    end

    it "redirects to index page" do
      delete :destroy, id: @cart
      expect(response).to redirect_to store_url
    end
  end
end
