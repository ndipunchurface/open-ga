require 'spec_helper'

describe "RegistrationNumbers" do
  describe "GET /registration_numbers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get registration_numbers_index_path
      response.status.should be(200)
    end
  end
end
