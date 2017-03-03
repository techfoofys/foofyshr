# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@foofys.com', password: 'foofys123', password_confirmation: 'foofys123')
Designation.create!(title: 'HR' , description: 'HR')
Role.create!(title: 'HR' , description: 'HR')
Status.create!(title: 'True' )
Status.create!(title: 'False' )
