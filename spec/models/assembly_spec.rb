require 'spec_helper'

describe Assembly do
  let(:user) { Factory.create(:user) }

  it "should authorize owner upon save" do
    assembly = Factory.create(:assembly, :user => user)
    user.authorized?(assembly).should === true
  end

  it "should alias upon save" do
    assembly = Factory.create(:assembly)
    assembly.alias.nil?.should === false
  end

end
