require 'rails_helper'

describe 'user management' do
  it "adds a new user" do
    sign_in
    visit store_url
    expect{
      click_link 'Users'
      click_link 'New User'
      fill_in 'Name',with: 'Ekta'
      fill_in 'Password' , with: 'ekta'
      fill_in 'Confirm' , with: 'ekta'
      click_button 'Create User'
    }.to change(User,:count).by(1)
    expect(current_path).to eq users_path
   expect(page).to have_content "User Ekta was successfully created"
    within 'h1' do
      expect(page).to have_content 'Listing users'
    end
    page.should have_content 'Ekta'
  end
end
