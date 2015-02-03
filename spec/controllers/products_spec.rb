require 'rails_helper'

describe ProductsController do
  before { @user = login_user }

  describe 'GET #index' do
    it "populates an array of products" do
     create_list :product, 2
     get :index
     expect(assigns(:products).count).to eq(2)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:product) { create :product }

    it "shows requested product to @product" do
      get :show, id: product
      expect(assigns(:product)).to eq product
    end

    it "renders the :show template" do
      get :show, id: product
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assign new product to @product" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'GET #edit' do
    it "assign requested product to @product" do
      product = create :product
      get :edit, id: product
      expect(assigns(:product)).to eq(product)
    end
    it "renders the :edit template" do
      product = create :product
      get :edit, id: product
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves new product in the database" do
        expect{
          post :create , product: attributes_for(:product)
        }.to change(Product,:count).by(1)
      end
      it "renders to show page" do
        post :create , product: attributes_for(:product)
        expect(response).to redirect_to Product.last#product_path(assigns(:product))
      end
    end
    context "with invalid attributes" do
      it "do not save product to database" do
        # @product = {title: "sky", description: "It is sample", image_url: "cc.png", price: 1, locale: "en"}
         expect{
          post :create ,product: attributes_for(:invalid_product)
        }.to_not change(Product,:count)
      end
      it "re-renders the new:template" do
        post :create ,product: attributes_for(:invalid_product)
        expect(response).to render_template("new")
      end
    end
  end

  describe 'PUT #update' do
    before do
      @product = create :product#, title: "Computer World", description: "It is computer world", image_url: "cc.png", price: "123", locale: "en")
    end

    it "locates the requested @product" do
      put :update, id: @product, product: attributes_for(:product)
      expect(assigns(:product)).to eq(@product)
    end

    context "with valid attributes" do
      it "update product in database" do
        put :update, id: @product, product: attributes_for(:product, title: "Computer World")
        @product.reload
        expect(@product.title).to eq("Computer World")
      end
      it "redirects to product" do
        put :update, id: @product, product: attributes_for(:product)
        expect(response).to redirect_to @product
      end
    end

    context "with invalid attributes" do
      it "does not update product" do
        put :update, id: @product, product: attributes_for(:product, title: "Computer World", price: nil)
        expect(@product.title).to_not eq("Computer World")
      end
      it "re-renders the #edit template" do
        put :update, id: @product, product: attributes_for(:invalid_product)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { @product = create :product }

    it "delete the product from database" do
      expect{
        delete :destroy, id: @product
      }.to change(Product, :count).by(-1)
    end

    it "redirects to index page" do
      delete :destroy, id: @product
      expect(response).to redirect_to "/products"
    end
  end

  describe "atom feed" do
    it "renders who_bought" do
      @product = create :product
      get :who_bought, id: @product.id
      expect(response).to redirect_to @product
    end
  end
end
