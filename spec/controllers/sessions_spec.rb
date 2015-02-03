require 'rails_helper'

describe SessionsController do
  describe 'POST #create' do
    context "User present" do
      it "User not logged in" do
        @user = create :user
        post :create, name: @user
        expect(response).to redirect_to login_url
      end

      it "user is logged in" do
        @user = login_user
        post :create, name: @user.name, password: @user.password
           expect(response).to redirect_to admin_url
      end
    end

    context "User not present" do
      it "redirect to new user path" do
        post :create
        expect(response).to redirect_to new_user_path
      end
    end
  end

  describe 'DELETE #destroy' do
    it "logout user" do
      delete :destroy
      expect(response).to redirect_to store_url
    end
  end
end
