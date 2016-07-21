# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

path = File.join(Rails.root, 'app', 'csvs')

=begin
=end
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

/
/
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
    username, firstname, lastname, email, phone, password, org_id, status, password_reset_token, password_reset_sent_at = user.chomp.split(',')
    User.create!(
      username: username, 
      firstname: firstname,
      lastname: lastname,
      email: email,
      phone: phone,
      password: password,
      password_confirmation: password,
      organization_id: org_id,
      status: status,
      password_reset_token: nil,
      password_reset_sent_at: nil,
    )
  end
end

# Seeding UserLabGroup data
Membership.delete_all
File.open( File.join(path, 'memberships.csv'), 'r') do |file|
  file.read.each_line do |member|
    user_id, lab_group_id = member.chomp.split(',')
    Membership.create!(user_id: user_id, lab_group_id: lab_group_id)
  end
end

# Seeding Roles data
Role.delete_all
File.open( File.join(path, 'roles.csv'), 'r') do |file|
  file.read.each_line do |role|
    name, description = role.chomp.split(',')
    Role.create!(name: name, description: description)
  end
end

# Seeding Privileges data
Privilege.delete_all
File.open( File.join(path, 'privileges.csv'), 'r') do |file|
  file.read.each_line do |priv|
    role_id, user_id = priv.chomp.split(',')
    Privilege.create!(role_id: role_id, user_id: user_id)
  end
end


# Seeding Platforms data
Platform.delete_all
File.open( File.join(path, 'platforms.csv'), 'r') do |file|
  file.read.each_line do |platform|
    name, code = platform.chomp.split(',')
    Platform.create!(name: name, code: code)
  end
end

# Seeding Proposal status data
ProposalStatus.delete_all
File.open( File.join(path, 'proposal_status.csv'), 'r') do |file|
  file.read.each_line do |status|
    name, code = status.chomp.split(',')
    ProposalStatus.create!(name: name, code: code)
  end
end

# Seeding Vote data
Vote.delete_all
File.open( File.join(path, 'votes.csv'), 'r') do |file|
  file.read.each_line do |vote|
    name = vote.chomp
    Vote.create!(name: name)
  end
end

# Seeding Sample Type data
SampleType.delete_all
File.open( File.join(path, 'sample_types.csv'), 'r') do |file|
  file.read.each_line do |st|
    name = st.chomp
    SampleType.create!(name: name)
  end
end

