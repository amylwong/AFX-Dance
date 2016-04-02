# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin_type: 'admin')
AdminUser.create(email: 'board@example.com', password: 'password', password_confirmation: 'password', admin_type: 'board')
AdminUser.create(email: 'project@example.com', password: 'password', password_confirmation: 'password', admin_type: 'project')
AdminUser.create(email: 'training@example.com', password: 'password', password_confirmation: 'password', admin_type: 'training')
Dancer.create(name: 'Michael', email: 'michael@example.com', phone: '909-569-5555', year: '1', gender: 'M')