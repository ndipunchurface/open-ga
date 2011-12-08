# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    user_id 1
    assembly_uuid "MyString"
  end
end
