# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

path = File.join(Rails.root, 'app', 'csvs')
# Seeding States data
State.delete_all

File.open( File.join(path, 'states.csv'), 'r') do |file|
  file.read.each_line do |state|
    name, code = state.chomp.split(',')
    State.create!(name: name, code: code)
  end
end

# Seeding Address data
Address.delete_all
File.open( File.join(path, 'addresses.csv'), 'r') do |file|
  file.read.each_line do |address|
    street, city, country, state_id = address.chomp.split(',')
    Address.create!(street: street, city: city, country: country, state_id: state_id)
  end
end
