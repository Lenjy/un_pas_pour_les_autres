# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

# JoinedTeam.destroy_all
# puts 'JT destroyed'
# Step.destroy_all
# puts 'steps destroyed'
# # User.destroy_all
# # puts 'users destroyed'
# Team.destroy_all
# puts 'teams destroyed'
# Campaign.destroy_all
# puts 'caamp destroyed'
# Enterprise.destroy_all
# puts 'enterp destroyed'
# CharityEvent.destroy_all
# puts 'ch ev destroyed'



# CHARITY EVENTS

handicap_international = CharityEvent.new(
  title: "Evenement Handicap International 2021",
  charity_name: "Handicap International",
  description: "Handicap International est une ONG de solidarité internationale qui intervient dans une soixantaine de pays. L’association intervient dans les situations de pauvreté et d’exclusion, de conflits et de catastrophes aux côtés des personnes handicapées et des populations vulnérables.",
  date_beginning: Date.new(2021, 1, 01),
  date_ending: Date.new(2021, 1, 25),
  total_donation: 456067
  )

handicap_international.save

photo_handicap_international = URI.open('https://handicap-international.fr/sn_uploads/fck/L_Handicap_FR_Small_Horiz_blue_rgb.png')
handicap_international.photo.attach(io: photo_handicap_international, filename: 'handicap_international.png', content_type: 'image/png')



medecins_sans_frontieres = CharityEvent.new(
  title: "Evenement Sans Frontières 2021",
  charity_name: "Médecins sans Frontières",
  description: "Depuis près de cinquante ans, Médecins Sans Frontières apporte une assistance médicale à des populations dont la vie ou la santé sont menacées, en France ou à l'étranger : principalement en cas de conflits armés, mais aussi d'épidémies, de pandémies, de catastrophes naturelles ou encore d'exclusion des soins.",
  date_beginning: Date.new(2021, 2, 01),
  date_ending: Date.new(2021, 2, 25),
  total_donation: 90256
  )

medecins_sans_frontieres.save

photo_medecins_sans_frontieres = URI.open('https://upload.wikimedia.org/wikipedia/fr/thumb/6/69/MSF.svg/1200px-MSF.svg.png')
medecins_sans_frontieres.photo.attach(io: photo_medecins_sans_frontieres, filename: 'medecins_sans_frontieres.png', content_type: 'image/png')



fondation_abbe_pierre = CharityEvent.create!(
  title: "Evenement Abbé Pierre 2021",
  charity_name: "Fondation Abbé Pierre",
  description: "La fondation Abbé-Pierre pour le logement des défavorisés (FAP), reconnue d'utilité publique le 11 février 1992 , a pour mission de permettre à toute personne démunie d'accéder à un logement décent et à une vie digne, quels que soient le montant de ses ressources et sa situation sociale.",
  date_beginning: Date.new(2021, 4, 01),
  date_ending: Date.new(2021, 4, 25),
  total_donation: 145304
  )

photo_fondation_abbe_pierre = URI.open('https://www.tousbenevoles.org/images/association/1565005876.png')
fondation_abbe_pierre.photo.attach(io: photo_fondation_abbe_pierre, filename: 'fondation_abbe_pierre.png', content_type: 'image/png')


restos_du_coeur = CharityEvent.create!(
  title: "Evenement Coluche 2021",
  charity_name: "Les Restos du Coeur",
  description: "Fondés par Coluche en 1985, les Restos du Coeur est une association loi de 1901, reconnue d’utilité publique, sous le nom officiel de Les Restaurants du Coeur – les Relais du Coeur.",
  date_beginning: Date.new(2021, 5, 23),
  date_ending: Date.new(2021, 6, 07),
  total_donation: 0
  )

  puts "Created #{CharityEvent.all.size} charity events in seeds.rb"


#   # ENTERPRISES

 tables_5_6 = Enterprise.create!(name: "Tables 5 et 6")
 tables_1_2 = Enterprise.create!(name: "Tables 1 et 2")
 tables_3_4 = Enterprise.create!(name: "Tables 3 et 4")

  puts "Created #{Enterprise.all.size} enterprises in seeds.rb"

# # CAMPAIGNS

campaign_restos_du_coeur_tables_5_6 = Campaign.create!(
  step_conversion: 0,
  max_contribution: 100000,
  charity_event: restos_du_coeur,
  enterprise: tables_5_6,
)

campaign_restos_du_coeur_tables_1_2 = Campaign.create!(
  step_conversion: 0,
  max_contribution: 100000,
  charity_event: restos_du_coeur,
  enterprise: tables_1_2,
)

campaign_restos_du_coeur_tables_3_4 = Campaign.create!(
  step_conversion: 0,
  max_contribution: 100000,
  charity_event: restos_du_coeur,
  enterprise: tables_3_4,
)

puts "Created #{Campaign.all.size} campaigns in seeds.rb"




# # USERS=
# basil = User.all.where(email: "basil.lizotte@gmail.com").first
# arthur = User.all.where(email: "maguinarthur@gmail.com").first
# benjamin = User.all.where(email: "be.eycken@gmail.com").first
# maylis = User.all.where(email: "mdlmaylis@gmail.com").first


# # basil = User.create!(first_name: "Basil", last_name: "Lizotte", nickname: "lizottebasil", address: "4 rue Victor Masse", phone_number: "0675674509", email: "basil@gmail.com", password: "123456", password_confirmation: "123456")

# # arthur = User.create!(first_name: "Arthur", last_name: "Maguin", nickname: "maguinarthur", address: "20 rue Victor Masse", phone_number: "0675674512", email: "arthur@gmail.com", password: "123456", password_confirmation: "123456")

# # benjamin = User.create!(first_name: "Benjamin", last_name: "Eycken", nickname: "eyckenbenjamin", address: "20 rue Victor Masse", phone_number: "0675674512", email: "be.eycken@gmail.com", password: "123456", password_confirmation: "123456")

# # maylis = User.create!(first_name: "Maylis", last_name: "De La Monneraye", nickname: "dlmmaylis", address: "20 rue Victor Masse", phone_number: "0675674512", email: "maylis@gmail.com", password: "123456", password_confirmation: "123456")

# photo_basil = URI.open('./app/assets/images/basil.jpeg')
# basil.photo.attach(io: photo_basil, filename: 'basil_demo.jpg', content_type: 'image/jpg')

# photo_arthur = URI.open('./app/assets/images/arthur.jpeg')
# arthur.photo.attach(io: photo_arthur, filename: 'arthur_demo.jpg', content_type: 'image/jpg')

# photo_benjamin = URI.open('./app/assets/images/benjamin.jpeg')
# benjamin.photo.attach(io: photo_benjamin, filename: 'benjamin_demo.jpg', content_type: 'image/jpg')

# photo_maylis = URI.open('./app/assets/images/maylis.webp')
# maylis.photo.attach(io: photo_maylis, filename: 'maylis_demo.jpg', content_type: 'image/jpg')



# puts "Created #{User.all.size} users in seeds.rb"



# # STEPS

# def is_integer(number)
#   number.floor == number
# end


# (3..30).each do |i|

#   Step.create!(
#   date: Date.parse("2021-05-#{i}") ,
#   nb_steps: rand(1000..15000),
#   week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
#   user_id: basil.id)

#   Step.create!(
#   date: Date.parse("2021-05-#{i}") ,
#   nb_steps: rand(1000..15000),
#   week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
#   user_id: arthur.id)

#   Step.create!(
#   date: Date.parse("2021-05-#{i}") ,
#   nb_steps: rand(1000..15000),
#   week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
#   user_id: benjamin.id)

#   Step.create!(
#   date: Date.parse("2021-05-#{i}") ,
#   nb_steps: rand(1000..15000),
#   week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
#   user_id: maylis.id)

# end

# # steps_basil = Step.create!(
# #   date: Date.today,
# #   nb_steps: 12145,
# #   week: 1,
# #   user_id: basil.id,
# # )

# # steps_arthur = Step.create!(
# #   date: Date.today,
# #   nb_steps: 11147,
# #   week: 1,
# #   user_id: arthur.id,
# # )

# # steps_benjamin = Step.create!(
# #   date: Date.today,
# #   nb_steps: 14500,
# #   week: 1,
# #   user_id: benjamin.id,
# # )

# # steps_maylis = Step.create!(
# #   date: Date.today,
# #   nb_steps: 8943,
# #   week: 1,
# #   user_id: maylis.id,
# # )

# puts "Created #{Step.all.size} steps instances for users in seeds.rb"


# # TEAMS

uppla = Team.create!(
name: "Un pas pour les autres",
description: "The best team ever seen at the Wagon",
campaign: campaign_restos_du_coeur_tables_5_6)

Team.create!(
name: "Gamer meets",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_5_6)

Team.create!(
name: "Tinder for brands",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_3_4)

Team.create!(
name: "Le plateau",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_1_2)

Team.create!(
name: "Book society",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_1_2)

Team.create!(
name: "Sound on",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_3_4)


puts "Created #{Team.all.size} team instances in seeds.rb"



# # JOINED TEAMS


# JoinedTeam.create!(
#   user: arthur,
#   team: uppla)

# JoinedTeam.create!(
#   user: basil,
#   team: uppla)

# JoinedTeam.create!(
#   user: benjamin,
#   team: uppla)

# JoinedTeam.create!(
#   user: maylis,
#   team: uppla)


# puts "Created #{JoinedTeam.all.size} joined team instances in seeds.rb"

