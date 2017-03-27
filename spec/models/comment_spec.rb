require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is valid with valid attributes" do
    expect(Comment.new(body:'commentbody')).to be_valid
  end

  it "is not valid without a body" do
    expect(Comment.new).to_not be_valid
  end
end
