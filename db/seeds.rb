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

# Create this month's expenses
100.times do 
  user.expenses.create(date: Faker::Date.backward(30),
                       amount: Faker::Number.decimal(2, 2),
                       description: [Faker::HarryPotter.quote,
                                     Faker::HarryPotter.book].sample
                      )
end

