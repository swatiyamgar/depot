require 'rails_helper' # use instead of spec_helper
describe Product do

  it "has a valid factory" do
    expect(create(:product)).to be_valid #crate a valid product by using product fixture
  end

  it "is invalid without title" do
    expect(build(:product,title: nil)).to be_invalid
  end

  it "is invalid without description" do
    expect(build(:product,description: nil)).to be_invalid
  end

  it "is invalid without image_url" do
    expect(build(:product,image_url: nil)).to be_invalid
  end

  it "has a unique title" do
    create(:product, title:"laptop dell")
    expect(build(:product, title:"laptop dell")).to be_invalid
  end

  it "has minimum 10 character title" do
    a = create(:product, title: "laptop dell")
    expect(a.title.length).to be >= 10
  end

  describe "#latest" do
    it "should show latest product" do
      product = create :product
      product1 = create :product
      product.update_attribute :price, 12
      expect(Product.latest).to eq(product)
    end
  end

  describe "#ensure_not_referenced_by_any_line_item" do
    it "should not prsent in line item while destroy product" do
      product = create :product
      line_item = create :line_item
      expect(product).to receive(:ensure_not_referenced_by_any_line_item)
      product.run_callbacks(:destroy)
    end
  end

  describe "#ensure_not_referenced_by_any_line_item" do
    it "should not prsent in line item while destroy product" do
      product = create :product
      line_item = create :line_item, product: product
      expect(product.destroy).to be_falsy
      expect(product.errors[:base]).to include("line items present")
    end

    it "should not prsent in line item while destroy product" do
      product = create :product
      expect{
        product.destroy
      }.to change(Product, :count).by(-1)
    end
  end

  #it "is invalid without specific image format" do
    # expect(build(:product, image_url: 'ruby.jpg')).to be_kind_of('.jpg')
  #end

  #it "has a gif,png,jpg format of image_url" do
  #end

end
