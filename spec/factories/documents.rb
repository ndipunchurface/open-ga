# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    documentable_id 1
    documentable_type "MyString"
    name "MyString"
    body "MyText"
  end
end
