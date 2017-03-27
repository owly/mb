require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with valid attributes" do
    expect(Post.new(body:'body', title:'post title')).to be_valid
  end

  it "is not valid without a body" do
    expect(Post.new(title:'post title')).to_not be_valid
  end
  it "is not valid without a title" do
    expect(Post.new(body:'body')).to_not be_valid
  end
end
