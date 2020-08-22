require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  let(:user){User.create(name: "name")}
  
  before :each do
    assign(:current_user, user)
  end

  describe "#logged_in_user" do
    it "returns the correct string" do
      expect(helper.logged_in_user).to eq('Logged_in user: ')
    end
  end

  describe "#current_user_name" do
    it "returns the current user name" do
      expect(helper.current_user_name).to eq(user.name)
    end
  end

  describe "#current_user_id" do
    it "returns the current user id" do
      expect(helper.current_user_id).to eq(user.id)
    end
  end

  describe "#current_user" do
    it "returns the current user" do
      expect(helper.current_user).to eq(user)
    end
  end
end