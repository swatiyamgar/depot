require 'rails_helper'

describe Payment do
  describe "associations" do
    it { should have_many :orders }
  end
end
