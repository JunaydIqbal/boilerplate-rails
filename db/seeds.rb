# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


admin = User.create(
  full_name: "Admin 1", 
  email: "admin@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  phone_no: "+12334432493", 
  role: "admin"
)

puts "*** Admin with email: #{admin.email} created! ***"; puts

user = User.create(
  full_name: "User 1", 
  email: "user@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  phone_no: "+12334432493", 
  role: "user"
)

puts "*** User with email: #{user.email} created! ***"