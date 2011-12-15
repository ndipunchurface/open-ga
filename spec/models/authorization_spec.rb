require 'spec_helper'

describe Authorization do
  let(:owner) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly, :user => owner) }
  it "should return number of admins" do
    3.times do
      user = Factory.create(:user)
      user.authorize(assembly, 1)
    end

    Authorization.num_admins(assembly).should == 4 # 3 facilitators + 1 owner
  end
end
