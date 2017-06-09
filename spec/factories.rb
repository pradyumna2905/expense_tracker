FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
  end

  factory :expense do
    user
    date { Date.today }
    description { 'Beer' }
    amount { Faker::Number.decimal(2, 2) }
  end
end
