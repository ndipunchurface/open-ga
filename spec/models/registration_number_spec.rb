require 'spec_helper'

describe RegistrationNumber do
  it "should burn a number as class" do
    num = RegistrationNumber.create({:active => true})
    RegistrationNumber.burn_number(num.number)
    num2 = RegistrationNumber.find_by_number(num.number)
    num2.active.should == false
  end

  it "should burn number as object" do
    num = RegistrationNumber.create({:active => true})
    num.burn_number
    num.active.should == false
  end

  it "should randomize number" do
    num = RegistrationNumber.new({:number => "random"})
    num.number.should == "random"
    num.save
    num.number.should_not == "random"
  end
end
