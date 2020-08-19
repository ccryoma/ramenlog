require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:post) { create(:post,:test0) }

  it "Postは有効である" do
    expect(post).to be_valid
  end

  it "titleは必須である" do
    post.title = "   "
    expect(post).to_not be_valid
  end

  it "commentは必須である" do
    post.comment = "   "
    expect(post).to_not be_valid
  end

  it "pointは必須である" do
    post.point = "   "
    expect(post).to_not be_valid
  end

  it "titleは50文字以内である" do
    post.title = "a" * 51
    expect(post).to_not be_valid
  end

  it "commentは3000字以内である" do
    post.comment = "a" * 3001
    expect(post).to_not be_valid
  end

  it "pointは5.0以下である" do
    post.point = 5.1
    expect(post).to_not be_valid
  end

  it "pointは0.0以上である" do
    post.point = -0.1
    expect(post).to_not be_valid
  end
end
