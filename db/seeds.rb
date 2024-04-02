# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


admin = Users::Admin.create(
  first_name: "Admin FirstName",
  last_name: "LastName",
  email: "admin@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  phone_no: "+12334432493"
)

puts "*** Admin with email: #{admin.email} created! ***"; puts

user = Users::Assessor.create(
  first_name: "Assessor firstname",
  last_name: "LastName",
  email: "user@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  phone_no: "+12334432493"
)

puts "*** Assessor with email: #{user.email} created! ***"

client = Users::Client.create(
  first_name: "Client firstname",
  last_name: "LastName",
  email: "client@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  phone_no: "+12334432493"
)

puts "*** Client with email: #{client.email} created! ***"

super_admin = Users::SuperAdmin.create(
  first_name: "SuperAdmin firstname",
  last_name: "LastName",
  email: "super@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  phone_no: "+12334432493"
)

puts "*** Client with email: #{super_admin.email} created! ***"