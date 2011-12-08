# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flag do
    flaggable_id 1
    flaggable_type "MyString"
  end
end
