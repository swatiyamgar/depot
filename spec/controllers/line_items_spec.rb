require 'rails_helper'

describe LineItemsController do
  before { @user = login_user }

  describe 'POST #create' do
    before do
      @product = create :product
    end

    context "with valid attributes" do
      it "saves new line_item in the database" do
        expect{
          post :create, product_id: @product
        }.to change(LineItem,:count).by(1)
      end

      it "renders to show page" do
        post :create , product_id: @product
        expect(response).to redirect_to store_url
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @line_item = create :line_item
    end

    it "delete the line_item from database" do
      expect{
        delete :destroy, id: @line_item
      }.to change(LineItem, :count).by(-1)
    end

    it "redirects to index page" do
      delete :destroy, id: @line_item
      expect(response).to redirect_to store_url
    end
  end

  describe "line_item quantity more than one" do
    before { @line_item = create :line_item, quantity: 2 }

    it "decrese the quantity" do
      expect{
        delete :destroy, id: @line_item
        @line_item.reload
      }.to change(@line_item, :quantity).to(1)

    end

    it "redirects to index page" do
      delete :destroy, id: @line_item
      expect(response).to redirect_to store_url
    end
  end
end
