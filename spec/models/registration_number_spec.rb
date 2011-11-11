require 'spec_helper'

describe RegistrationNumber do
  it "should burn a number as class" do
    num = RegistrationNumber.create({:active => true})
    RegistrationNumber.burn_number(num.id)
    num2 = RegistrationNumber.find(num.id)
    num2.active.should == false
  end

  it "should burn number as object" do
    num = RegistrationNumber.create({:active => true})
    num.burn_number
    num.active.should == false
  end

end
