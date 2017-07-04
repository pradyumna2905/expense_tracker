FactoryGirl.define do
  factory :category do
    user
    title "Utility"
  end

  factory :payment_method do
    user
    name { 'Bank of America' }
  end

  factory :user do
    email { Faker::Internet.email }
    password 'password'
  end

  factory :expense do
    user
    date { Date.today }
    description { 'Beer' }
    payment_method
    amount { Faker::Number.decimal(2, 2) }
  end
end
