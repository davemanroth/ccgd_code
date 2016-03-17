# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seeding States data
State.delete_all
csv = File.join(Rails.root, 'app', 'csvs', 'states.csv')

File.open(csv, 'r') do |file|
  file.read.each_line do |state|
    name, code = state.chomp.split(',')
    State.create!(name: name, code: code)
  end
end
