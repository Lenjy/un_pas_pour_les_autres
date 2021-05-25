# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

Step.destroy_all
User.destroy_all
Enterprise.destroy_all
CharityEvent.destroy_all



# CHARITY EVENTS

restos_du_coeur = CharityEvent.create!(
  title: "Evenement Coluche 2021",
  charity_name: "Les Restos du Coeur",
  description: "Fondés par Coluche en 1985, les Restos du Coeur est une association loi de 1901, reconnue d’utilité publique, sous le nom officiel de Les Restaurants du Coeur – les Relais du Coeur.",
  date_beginning: Date.new(2021, 5, 23),
  date_ending: Date.new(2021, 6, 07),
  total_donation: 0
)

puts "Created #{CharityEvent.all.size} charity events in seeds.rb"


# ENTERPRISES

# le_wagon = Enterprise.create!(name: "Le Wagon")


# puts "Created #{Enterprise.all.size} enterprises in seeds.rb"

# USERS

basil = User.create!(first_name: "Basil", last_name: "Lizotte", nickname: "lizottebasil", address: "4 rue Victor Masse", phone_number: "0675674509", email: "basil@gmail.com", password: "123456", password_confirmation: "123456")

arthur = User.create!(first_name: "Arthur", last_name: "Maguin", nickname: "maguinarthur", address: "20 rue Victor Masse", phone_number: "0675674512", email: "arthur@gmail.com", password: "123456", password_confirmation: "123456")

benjamin = User.create!(first_name: "Benjamin", last_name: "Eycken", nickname: "eyckenbenjamin", address: "20 rue Victor Masse", phone_number: "0675674512", email: "benjamin@gmail.com", password: "123456", password_confirmation: "123456")

maylis = User.create!(first_name: "Maylis", last_name: "De La Monneraye", nickname: "dlmmaylis", address: "20 rue Victor Masse", phone_number: "0675674512", email: "maylis@gmail.com", password: "123456", password_confirmation: "123456")

photo_basil = URI.open('https://media-exp1.licdn.com/dms/image/C4E03AQE3w6qncy7Plw/profile-displayphoto-shrink_400_400/0/1620132183102?e=1626912000&v=beta&t=SAQo11fB-mb9HerJn-MjDj96KS6ozEEMJRVnEyLUZrU')
basil.photo.attach(io: photo_basil, filename: 'basil_demo.jpg', content_type: 'image/jpg')

photo_arthur = URI.open('https://media-exp1.licdn.com/dms/image/C4E03AQELhBcLohE_3g/profile-displayphoto-shrink_400_400/0/1517456385177?e=1626912000&v=beta&t=TZYnAlkO6MwZR840tiSaZmY5t5CcFaAVWzxLaT8Zqm8')
arthur.photo.attach(io: photo_arthur, filename: 'arthur_demo.jpg', content_type: 'image/jpg')

photo_benjamin = URI.open('https://media-exp1.licdn.com/dms/image/C4E35AQFTnjoPrlT0xQ/profile-framedphoto-shrink_800_800/0/1606391706002?e=1622034000&v=beta&t=-m1RWqbR4Ggu9nioFGdzxhXxzd2LXXTkTWsI_aFLSHw')
benjamin.photo.attach(io: photo_benjamin, filename: 'benjamin_demo.jpg', content_type: 'image/jpg')

photo_maylis = URI.open('https://nihonkara.fr/wp-content/uploads/2019/10/maylis-guide-seoul-300x300.jpg.webp')
maylis.photo.attach(io: photo_maylis, filename: 'maylis_demo.jpg', content_type: 'image/jpg')



puts "Created #{User.all.size} users in seeds.rb"



# STEPS

steps_basil = Step.create!(
  date: Date.today,
  nb_steps: 12145,
  week: 1,
  user_id: basil.id,
)

steps_arthur = Step.create!(
  date: Date.today,
  nb_steps: 11147,
  week: 1,
  user_id: arthur.id,
)

steps_benjamin = Step.create!(
  date: Date.today,
  nb_steps: 14500,
  week: 1,
  user_id: benjamin.id,
)

steps_maylis = Step.create!(
  date: Date.today,
  nb_steps: 8943,
  week: 1,
  user_id: maylis.id,
)

puts "Created #{Step.all.size} steps instances for userss in seeds.rb"

