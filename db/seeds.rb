# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


require 'faker'
require 'populator'
# 
# User.populate(1) do |user|
#   street1 = Faker::Address.street_address(include_secondary = false)
#   city = Faker::Address.city
#   state = Faker::Address.state_abbr
#   zip = Faker::Address.zip
#   user.firstname = "admin"
#   user.lastname = "admin"
#   user.password = "123456"
#   user.password_confirmation = "123456"
#   user.street1 = street1
#   user.city = city
#   user.state = state
#   user.zipcode = zip
#   user.full_address = street1 + "<br />" + city + ", " + state + " " + zip
#   user.role = ['employee', 'investor']
# end


puts "Clearing Users"
User.delete_all

puts "Clearing Companies"
Company.delete_all

Employmentship.delete_all

puts "Clearing title loans"
TitleLoan.delete_all

puts "Clearing Orders"
Order.delete_all

puts "Clearing Customers"
Customer.delete_all

puts "Adding Norcross and Cummings"
Company.create!(:name => "Norcross", :phone => "770-449-5525", :street1 => "5935 South Norcross Tucker Rd", :street2 => "Suite 9", :city => "Norcross", :state => "GA", :zipcode => "3093")


puts "Adding Admin"



street1 = Faker::Address.street_address(include_secondary = false)
city = Faker::Address.city
state = Faker::Address.state_abbr
zip = Faker::Address.zip
User.create!(
:firstname => 'admin',
:lastname => 'admin',
:email => 'admin@admin.com',
:password => "123456",
:password_confirmation => "123456",
:street1 => street1,
:city => city,
:state => state,
:zipcode => zip,
:full_address => street1 + "<br />" + city + ", " + state + " " + zip,
:roles => ['admin']
)


