require 'spec_helper'

describe User do
  let(:owner) { Factory.create(:user) }
  let(:user) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly,:user => owner) }

  describe "admin status" do
    before(:each) do
      user.authorize(assembly)
    end

    it "returns false for is_admin? when user is not admin" do
      user.is_admin?(assembly).should == false
    end

    it "returns true for is_admin? when user is an owner" do
      other_assembly = Factory.create(:assembly, :user => user)
      user.is_admin?(other_assembly).should == true
    end

    it "returns true for is_admin? when user is an facilitator" do
      user.make_facilitator(assembly)
      user.is_admin?(assembly).should == true
    end
  end

  describe "facilitator status" do
    before(:each) do
      user.authorize(assembly)
    end

    it "returns true for is_facilitator? when user is an facilitator" do
      user.make_facilitator(assembly)
      user.is_facilitator?(assembly).should == true
    end

    it "returns false for is_facilitator? when user is a not admin" do
      user.is_facilitator?(assembly).should == false
    end

    it "returns false for is_facilitator? when user is owner" do
      owner.is_facilitator?(assembly).should == false
    end
  end

  describe "owner status" do
    before(:each) do
      user.authorize(assembly)
    end

    it "returns true for is_owner? when user is owner" do
      owner.is_owner?(assembly).should == true
    end

    it "returns false for is_owner? when user is a facilitator" do
      user.make_facilitator(assembly)
      user.is_owner?(assembly).should == false
    end

    it "returns false for is_owner? when user is not admin" do
      user.is_owner?(assembly).should == false
    end
  end

  it "can authorize user" do
    assembly = Factory.create(:assembly, :user => owner)
    user.authorize(assembly)
    user.authorized?(assembly).should === true
  end

  it "can unauthorize user" do
    assembly = Factory.create(:assembly, :user => owner)
    user.authorize(assembly)
    user.unauthorize(assembly)
    user.authorized?(assembly).should === false
  end

  it "should only write one authorization per user per assembly" do
    user.authorize(assembly)
    authorizations = user.authorizations.length
    user.make_facilitator(assembly)
    user.authorizations.length.should == authorizations
  end

  it "should write separate authoriaztion for separate assembly" do
    other_assembly = Factory.create(:assembly, :user => owner)
    user.authorize(assembly)
    authorizations = user.authorizations.length
    user.authorize(other_assembly)
    user.authorizations.length.should > authorizations
  end
end
