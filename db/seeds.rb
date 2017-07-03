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
5.times do
  user.payment_methods.create(name: Faker::Bank.name.upcase)
end

# Generate current week's data
100.times do
  user.expenses.create(date: Faker::Date.between(Date.today, 1.week.ago),
                       amount: Faker::Number.decimal(2, 2),
                       payment_method_id: user.payment_methods.sample.id,
                       description: Faker::Beer.name
                      )
end

# Generate current month's expenses
100.times do
  user.expenses.create(date: Faker::Date.between(Date.today, 1.year.ago),
                       amount: Faker::Number.decimal(2, 2),
                       payment_method_id: user.payment_methods.sample.id,
                       description: Faker::Beer.name
                      )
end
