# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create user
user = User.create(email: 'test@example.com',
                   password: 'password')

# Create some payment methods
payment_methods = ["Chase", "Bank of America", "Amex", "Discover"]

payment_methods.each do |pm|
  user.payment_methods.create(name: pm)
end

# Create categories
categories = ["Utilities", "Grocery", "Dining", "Travel"]

categories.each do |category|
  user.categories.create(title: category)
end

# Generate current months's data
[*1..11].each do |month_number|
  50.times do
    user.expenses.create(date: Faker::Date.between(month_number.months.ago, (month_number-1).months.ago),
                        amount: Faker::Number.decimal(2, 2),
                        payment_method_id: user.payment_methods.sample.id,
                        category_id: user.categories.sample.id,
                        description: [Faker::HarryPotter.quote,
                                      Faker::HarryPotter.book].sample
                        )
  end
end

