Factory.define :user do |user|
  user.sequence(:email)     { |n| "foo#{n}@example.com" }
  user.password               "password"
  user.password_confirmation  "password"
end

Factory.define :assembly_category do |category|
  category.name "Test Category"
end

Factory.define :assembly do |assembly|
  assembly.name               "Test Assembly"
  assembly.assembly_category_id 1
end

Factory.define :proposal do |proposal|
  proposal.sequence(:title)   { |n| "Proposal #{n}" }
  proposal.body               "yH2TYgTSNFbpD46nBcNg4QqB4TZwWjKNziCCEz0d9ifS0yTO1T5lOgwydysOBgJuGAdz9yHPARjH0W7CiahhHDJOxSqL5koBLHXkUrMJwHp3N1fSmV256uQeNgYhjia5dmvZ2bz0CJyQ"
end

Factory.define :amendment do |amendment|
  amendment.sequence(:title)  { |n| "Amendment #{n}" }
  amendment.body              "yH2TYgTSNFbpD46nBcNg4QqB4TZwWjKNziCCEz0d9ifS0yTO1T5lOgwydysOBgJuGAdz9yHPARjH0W7CiahhHDJOxSqL5koBLHXkUrMJwHp3N1fSmV256uQeNgYhjia5dmvZ2bz0CJyQ"
end

Factory.define :reply do |reply|
  reply.body                "a reply"
end
