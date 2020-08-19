require 'rails_helper'

RSpec.describe Shop, type: :model do

  let(:shop) { create(:shop,:minato) }

  it "Shopは有効である" do
    expect(shop).to be_valid
  end

  it "nameは必須である" do
    shop.name = "   "
    expect(shop).to_not be_valid
  end

  it "addressは必須である" do
    shop.address = "   "
    expect(shop).to_not be_valid
  end

  it "nameは50文字以内である" do
    shop.name = "a" * 51
    expect(shop).to_not be_valid
  end

  it "addressは100文字以内である" do
    shop.address = "a" * 101
    expect(shop).to_not be_valid
  end

  it "opening_oursは255文字以内である" do
    shop.opening_ours = "a" * 256
    expect(shop).to_not be_valid
  end

  it "parkingは50文字以内である" do
    shop.parking = "a" * 51
    expect(shop).to_not be_valid
  end
end
