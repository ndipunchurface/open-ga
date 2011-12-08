# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :taxonomy do
    taggable_id 1
    taggable_type "MyString"
    tag_id 1
  end
end
