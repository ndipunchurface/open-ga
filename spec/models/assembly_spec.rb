require 'spec_helper'

describe Assembly do
  let(:user) { Factory.create(:user) }

  it "should authorize owner upon save" do
    assembly = Factory.create(:assembly, :user => user)
    user.authorized?(assembly).should === true
  end

  it "should alias upon save" do
    assembly = Factory.create(:assembly, :user => user)
    assembly.alias.nil?.should === false

    Alias.find_by_name(assembly.alias.name).nil?.should == false
  end

  it "should find by alias" do
    assembly = Factory.create(:assembly, :user => user)
    
    assembly2 = Assembly.find_by_uuid_or_alias(assembly.alias.name)
    assembly2.uuid.should == assembly.uuid
  end

end
