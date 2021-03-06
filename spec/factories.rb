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

  factory :transaction do
    user
    date { Date.today }
    description { 'Beer' }
    amount { Faker::Number.decimal(2, 2) }
    payment_method_id { user.payment_methods.first.id }
    category_id { user.categories.first.id }
  end
end
