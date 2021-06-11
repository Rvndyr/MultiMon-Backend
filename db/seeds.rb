# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.create!(username: "Randy", email: "Randy@test.com", password_digest: "password")
view = View.create!(user_id: 1, username: "engagenkill")
view = View.create!(user_id: 1, username: "nickmercs")

