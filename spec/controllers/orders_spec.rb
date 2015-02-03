require 'rails_helper'

describe OrdersController do
  before { @user = login_user }

  describe 'GET #new' do
    it "assign new order to @order" do
      get :new
      expect(response).to redirect_to store_url
    end
    context "line_items present" do

      before do
        cart = create :cart
        line_items = create_list :line_item, 2, cart: cart
        session[:cart_id] = cart.id
        get :new
      end

      it "assign new order to @order" do
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end


  describe 'POST #create' do
    context "with valid attributes" do
      it "saves new order in the database" do
        expect{
          post :create  ,order: attributes_for(:order)
        }.to change(Order,:count).by(1)
      end
       it "renders to index page" do
         post :create ,order: attributes_for(:order)
         expect(response).to redirect_to store_url
       end
    end
    context "with invalid attributes" do
      it "do not save order to database" do
         expect{
          post :create ,order: attributes_for(:invalid_order)
        }.to_not change(Order,:count)
      end
      it "re-renders the new:template" do
          post :create ,order: attributes_for(:invalid_order)
          expect(response).to render_template :new
      end
    end
 end


end
