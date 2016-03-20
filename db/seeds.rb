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

# Seeding Location data
Location.delete_all
File.open( File.join(path, 'locations.csv'), 'r') do |file|
  file.read.each_line do |location|
    building, room, address_id = location.chomp.split(',')
    Location.create!(building: building, room: room, address_id: address_id)
  end
end

# Seeding Organization data
Organization.delete_all
File.open( File.join(path, 'organizations.csv'), 'r') do |file|
  file.read.each_line do |org|
    name, phone, email, address_id = org.chomp.split(',')
    Organization.create!(name: name, phone: phone, email: email, address_id: address_id)
  end
end

# Seeding LabGroup data
LabGroup.delete_all
File.open( File.join(path, 'labgroups.csv'), 'r') do |file|
  file.read.each_line do |labgroup|
    name, code, location_id = labgroup.chomp.split(',')
    LabGroup.create!(name: name, code: code, location_id: location_id)
  end
end

# Seeding User data
User.delete_all
File.open( File.join(path, 'users.csv'), 'r') do |file|
  file.read.each_line do |user|
    username, firstname, lastname, email, phone, password, org_id, loc_id, status = user.chomp.split(',')
    User.create!(
      username: username, 
      firstname: firstname,
      lastname: lastname,
      email: email,
      phone: phone,
      password: password,
      password_confirmation: password,
      organization_id: org_id,
      location_id: loc_id,
      status: status
    )
  end
end
