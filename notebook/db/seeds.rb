# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Gerando os registros de Kind"
Kind.create(
			[{
				description: "Amigo"
			}, 
			{
				description: "Contato"
			}, 
			{
				description: "Comercial"
			}])
puts "Gerando os registros de Kind... [OK]"


puts "Gerando os registros de Contacts"
10.times do |i|
	Contact.create(
				[{
					name: Faker::Name.name,
					email: Faker::Internet.email,
					kind: Kind.all.sample,
					rmk: Faker::Lorem.sentence(3)
				}])
end
puts "Gerando os registros de Contacts... [OK]"

