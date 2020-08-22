require "rails_helper"

RSpec.describe SessionsHelper, :type => :helper do
  let(:user){User.create(name: "name")}
  
  before :each do
    assign(:current_user, user)
  end

  describe "#welcome" do
    it "returns the correct string" do
      expect(helper.welcome).to eq("Nice to see you again, #{user.name}!")
    end
  end
end