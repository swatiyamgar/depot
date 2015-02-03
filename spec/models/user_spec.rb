require 'rails_helper'

describe User do

  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:user, name: nil)).to be_invalid
  end

  it "is invalid for duplicate names" do
    create(:user, name:'sky')
    expect(build(:user, name: 'sky')).to be_invalid
  end

  describe "#ensure_not_referenced_by_any_line_item" do
    it "should not prsent in line item while destroy product" do
      user = create :user
      expect(user).to receive(:ensure_an_admin_remains)
      user.run_callbacks(:destroy)
    end
  end

end
