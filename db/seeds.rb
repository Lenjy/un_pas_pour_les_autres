# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

JoinedTeam.destroy_all
puts '- Joined Teams destroyed'
JoinedCampaign.destroy_all
puts '- Joined Campaigns destroyed'
DonationPayment.destroy_all
puts '- Donation Payments destroyed'
Step.destroy_all
puts '- Steps destroyed'
User.destroy_all
puts '- Users destroyed'
Team.destroy_all
puts '- Teams destroyed'
Campaign.destroy_all
puts '- Campaigns destroyed'
Enterprise.destroy_all
puts '- Enterprises destroyed'
CharityEvent.destroy_all
puts '- Charity Events destroyed'



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




# ENTERPRISES

# le_wagon = Enterprise.create!(name: "Le Wagon")

tables_5_6 = Enterprise.create!(name: "Tables 5 et 6")
tables_1_2 = Enterprise.create!(name: "Tables 1 et 2")
tables_3_4 = Enterprise.create!(name: "Tables 3 et 4")

puts "Created #{Enterprise.all.size} enterprises in seeds.rb"

# CAMPAIGNS

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






# basil = User.create!(first_name: "Basil", last_name: "Lizotte", nickname: "lizottebasil", address: "4 rue Victor Masse", phone_number: "0675674509", email: "basil@gmail.com", password: "123456", password_confirmation: "123456")

# USERS=

basil = User.create!(first_name: "Basil", last_name: "Lizotte", nickname: "lizottebasil", address: "4 rue Victor Masse", phone_number: "0675674509", email: "basil.lizotte@gmail.com", password: "123456", password_confirmation: "123456")

arthur = User.create!(first_name: "Arthur", last_name: "Maguin", nickname: "maguinarthur", address: "20 rue Victor Masse", phone_number: "0675674512", email: "maguinarthur@gmail.com", password: "123456", password_confirmation: "123456")

benjamin = User.create!(first_name: "Benjamin", last_name: "Eycken", nickname: "eyckenbenjamin", address: "20 rue Victor Masse", phone_number: "0675674512", email: "be.eycken@gmail.com", password: "123456", password_confirmation: "123456")

maylis = User.create!(first_name: "Maylis", last_name: "de La Monneraye", nickname: "dlmmaylis", address: "20 rue Victor Masse", phone_number: "0675674512", email: "mdlmaylis@gmail.com", password: "123456", password_confirmation: "123456")





photo_basil = URI.open('./app/assets/images/basil.jpeg')
basil.photo.attach(io: photo_basil, filename: 'basil_demo.jpg', content_type: 'image/jpg')

photo_arthur = URI.open('./app/assets/images/arthur.jpeg')
arthur.photo.attach(io: photo_arthur, filename: 'arthur_demo.jpg', content_type: 'image/jpg')

photo_benjamin = URI.open('./app/assets/images/benjamin.jpeg')
benjamin.photo.attach(io: photo_benjamin, filename: 'benjamin_demo.jpg', content_type: 'image/jpg')

photo_maylis = URI.open('./app/assets/images/maylis.webp')
maylis.photo.attach(io: photo_maylis, filename: 'maylis_demo.jpg', content_type: 'image/jpg')





mamoun = User.create!(first_name: "Mamoun", last_name: "Benbra", nickname: "mamoun", address: "4 rue Victor Masse", phone_number: "0675674509", email: "mamounbenbra@gmail.com", password: "123456", password_confirmation: "123456")

henrik = User.create!(first_name: "Henrik", last_name: "Duerrfeld", nickname: "henrik", address: "20 rue Victor Masse", phone_number: "0675674512", email: "henrik.duerrfeld.20002@gmail.com", password: "123456", password_confirmation: "123456")

jiwon = User.create!(first_name: "Jiwon", last_name: "Eun", nickname: "jiwon", address: "4 rue Victor Masse", phone_number: "0675674509", email: "jiwon.eun@gmail.com", password: "123456", password_confirmation: "123456")

audrey = User.create!(first_name: "Audrey", last_name: "Lm", nickname: "audrey", address: "20 rue Victor Masse", phone_number: "0675674512", email: "audreylm33@gmail.com", password: "123456", password_confirmation: "123456")

anne = User.create!(first_name: "Anne", last_name: "Lepetit", nickname: "nne", address: "20 rue Victor Masse", phone_number: "0675674512", email: "lepetit.anne@gmail.com", password: "123456", password_confirmation: "123456")

mathieu = User.create!(first_name: "Mathieu", last_name: "Chaplain", nickname: "mathieu", address: "20 rue Victor Masse", phone_number: "0675674512", email: "mathieuchaplain@gmail.com", password: "123456", password_confirmation: "123456")

maxime = User.create!(first_name: "Maxime", last_name: "Jacob", nickname: "mjacob", address: "4 rue Victor Masse", phone_number: "0675674509", email: "mjacob.bayer@gmail.com", password: "123456", password_confirmation: "123456")

johann = User.create!(first_name: "Johann", last_name: "Bzaih", nickname: "johann", address: "20 rue Victor Masse", phone_number: "0675674512", email: "johann.bzaih@gmail.com", password: "123456", password_confirmation: "123456")

chenchen = User.create!(first_name: "Chenchen", last_name: "Zheng", nickname: "chenchen", address: "20 rue Victor Masse", phone_number: "0675674512", email: "chenchenzheng42@gmail.com", password: "123456", password_confirmation: "123456")

germain = User.create!(first_name: "Germain", last_name: "Loret", nickname: "germain", address: "4 rue Victor Masse", phone_number: "0675674509", email: "germain.loret@gmail.com", password: "123456", password_confirmation: "123456")

julien = User.create!(first_name: "Julien", last_name: "Loiseau", nickname: "julien", address: "20 rue Victor Masse", phone_number: "0675674512", email: "julien.loiseau@edu.escp.eu", password: "123456", password_confirmation: "123456")

cindy = User.create!(first_name: "Cindy", last_name: "Grenet", nickname: "cindyyyy4", address: "20 rue Victor Masse", phone_number: "0675674512", email: "cindyyyy4@gmail.com", password: "123456", password_confirmation: "123456")

louis = User.create!(first_name: "Louis", last_name: "Decheff", nickname: "louis", address: "4 rue Victor Masse", phone_number: "0675674509", email: "louisdecheff@gmail.com", password: "123456", password_confirmation: "123456")

nicolas = User.create!(first_name: "Nicolas", last_name: "Dubet", nickname: "nicolas", address: "20 rue Victor Masse", phone_number: "0675674512", email: "nicolas.dubet@gmail.com", password: "123456", password_confirmation: "123456")

lylian = User.create!(first_name: "Lylian", last_name: "Krizoua", nickname: "lylian", address: "20 rue Victor Masse", phone_number: "0675674512", email: "krizoualylian@gmail.com", password: "123456", password_confirmation: "123456")

chris = User.create!(first_name: "Chris", last_name: "Mendy", nickname: "kris", address: "20 rue Victor Masse", phone_number: "0675674512", email: "krismendy@gmail.com", password: "123456", password_confirmation: "123456")



basil = User.all.where(email: "basil.lizotte@gmail.com").first
arthur = User.all.where(email: "maguinarthur@gmail.com").first
benjamin = User.all.where(email: "be.eycken@gmail.com").first
maylis = User.all.where(email: "mdlmaylis@gmail.com").first

mamoun = User.all.where(email: "mamounbenbra@gmail.com").first
# baptiste = User.all.where(email: "").first
henrik = User.all.where(email: "henrik.duerrfeld.20002@gmail.com").first
# julien_d = User.all.where(email: "").first

jiwon = User.all.where(email: "jiwon.eun@gmail.com").first
audrey = User.all.where(email: "audreylm33@gmail.com").first
anne = User.all.where(email: "lepetit.anne@gmail.com").first
mathieu = User.all.where(email: "mathieuchaplain@gmail.com").first

maxime = User.all.where(email: "mjacob.bayer@gmail.com").first
johann = User.all.where(email: "johann.bzaih@gmail.com").first
chenchen = User.all.where(email: "chenchenzheng42@gmail.com").first

germain = User.all.where(email: "germain.loret@gmail.com").first
julien = User.all.where(email: "julien.loiseau@edu.escp.eu").first
# celia = User.all.where(email: "@gmail.com").first
cindy = User.all.where(email: "cindyyyy4@gmail.com").first

louis = User.all.where(email: "louisdecheff@gmail.com").first
nicolas = User.all.where(email: "nicolas.dubet@gmail.com").first
lylian = User.all.where(email: "krizoualylian@gmail.com").first
chris = User.all.where(email: "krismendy@gmail.com").first



basil.enterprise = tables_5_6
arthur.enterprise = tables_5_6
benjamin.enterprise = tables_5_6
maylis.enterprise = tables_5_6

jiwon.enterprise = tables_1_2
audrey.enterprise = tables_1_2
anne.enterprise = tables_1_2
mathieu.enterprise = tables_1_2

maxime.enterprise = tables_1_2
johann.enterprise = tables_1_2
chenchen.enterprise = tables_1_2
mamoun.enterprise = tables_1_2

julien.enterprise = tables_3_4
germain.enterprise = tables_3_4
cindy.enterprise = tables_3_4
henrik.enterprise = tables_3_4

louis.enterprise = tables_3_4
nicolas.enterprise = tables_3_4
lylian.enterprise = tables_3_4
chris.enterprise = tables_3_4


basil.save
arthur.save
benjamin.save
maylis.save

jiwon.save
audrey.save
anne.save
mathieu.save

maxime.save
johann.save
chenchen.save
mamoun.save

julien.save
germain.save
cindy.save
henrik.save

louis.save
nicolas.save
lylian.save
chris.save



puts "Created #{User.all.size} users in seeds.rb"



# STEPS

def is_integer(number)
  number.floor == number
end

date = Date.today

(3..61).each do |i|

  Step.create!(
  date: date,
  nb_steps: rand(1000..15000),
  week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
  user_id: basil.id)

  Step.create!(
  date: date,
  nb_steps: rand(1000..15000),
  week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
  user_id: arthur.id)

  Step.create!(
  date: date,
  nb_steps: rand(1000..15000),
  week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
  user_id: benjamin.id)

  Step.create!(
  date: date,
  nb_steps: rand(1000..15000),
  week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
  user_id: maylis.id)

  date = date.yesterday

end

# steps_basil = Step.create!(
#   date: Date.today,
#   nb_steps: 12145,
#   week: 1,
#   user_id: basil.id,
# )

# steps_arthur = Step.create!(
#   date: Date.today,
#   nb_steps: 11147,
#   week: 1,
#   user_id: arthur.id,
# )

# steps_benjamin = Step.create!(
#   date: Date.today,
#   nb_steps: 14500,
#   week: 1,
#   user_id: benjamin.id,
# )

# steps_maylis = Step.create!(
#   date: Date.today,
#   nb_steps: 8943,
#   week: 1,
#   user_id: maylis.id,
# )

puts "Created #{Step.all.size} steps instances for users in seeds.rb"


# TEAMS

shoes_qui_peut = Team.create!(
name: "Un pas pour les autres",
description: "The best team ever seen at the Wagon",
campaign: campaign_restos_du_coeur_tables_5_6)

feeler = Team.create!(
name: "Tinder for brands",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_3_4)

le_plateau = Team.create!(
name: "Le plateau",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_1_2)

book_society = Team.create!(
name: "Book society",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_1_2)

sound_on = Team.create!(
name: "Sound on",
description: "These guys are so lame",
campaign: campaign_restos_du_coeur_tables_3_4)


puts "Created #{Team.all.size} team instances in seeds.rb"



# JOINED TEAMS


JoinedTeam.create!(
  user: arthur,
  team: shoes_qui_peut)

JoinedTeam.create!(
  user: basil,
  team: shoes_qui_peut)

JoinedTeam.create!(
  user: benjamin,
  team: shoes_qui_peut)

JoinedTeam.create!(
  user: maylis,
  team: shoes_qui_peut)


JoinedTeam.create!(
  user: mamoun,
  team: le_plateau)

JoinedTeam.create!(
  user: henrik,
  team: sound_on)


JoinedTeam.create!(
  user: jiwon,
  team: book_society)

JoinedTeam.create!(
  user: audrey,
  team: book_society)

JoinedTeam.create!(
  user: anne,
  team: book_society)

JoinedTeam.create!(
  user: mathieu,
  team: book_society)


JoinedTeam.create!(
  user: maxime,
  team: le_plateau)

JoinedTeam.create!(
  user: johann,
  team: le_plateau)

JoinedTeam.create!(
  user: chenchen,
  team: le_plateau)


JoinedTeam.create!(
  user: cindy,
  team: sound_on)

JoinedTeam.create!(
  user: julien,
  team: sound_on)

JoinedTeam.create!(
  user: germain,
  team: sound_on)

JoinedTeam.create!(
  user: louis,
  team: feeler)

JoinedTeam.create!(
  user: nicolas,
  team: feeler)

JoinedTeam.create!(
  user: lylian,
  team: feeler)

JoinedTeam.create!(
  user: chris,
  team: feeler)

puts "Created #{JoinedTeam.all.size} joined team instances in seeds.rb"


# JOINED CAMPAIGNS

JoinedCampaign.create!(
  user: arthur,
  campaign: campaign_restos_du_coeur_tables_5_6
  )

JoinedCampaign.create!(
  user: maylis,
  campaign: campaign_restos_du_coeur_tables_5_6
  )

JoinedCampaign.create!(
  user: basil,
  campaign: campaign_restos_du_coeur_tables_5_6
  )

JoinedCampaign.create!(
  user: benjamin,
  campaign: campaign_restos_du_coeur_tables_5_6
  )

JoinedCampaign.create!(
  user: mamoun,
  campaign: campaign_restos_du_coeur_tables_1_2)

JoinedCampaign.create!(
  user: henrik,
  campaign: campaign_restos_du_coeur_tables_3_4)


JoinedCampaign.create!(
  user: jiwon,
  campaign: campaign_restos_du_coeur_tables_1_2)

JoinedCampaign.create!(
  user: audrey,
  campaign: campaign_restos_du_coeur_tables_1_2)

JoinedCampaign.create!(
  user: anne,
  campaign: campaign_restos_du_coeur_tables_1_2)

JoinedCampaign.create!(
  user: mathieu,
  campaign: campaign_restos_du_coeur_tables_1_2)


JoinedCampaign.create!(
  user: maxime,
  campaign: campaign_restos_du_coeur_tables_1_2)

JoinedCampaign.create!(
  user: johann,
  campaign: campaign_restos_du_coeur_tables_1_2)

JoinedCampaign.create!(
  user: chenchen,
  campaign: campaign_restos_du_coeur_tables_1_2)


JoinedCampaign.create!(
  user: cindy,
  campaign: campaign_restos_du_coeur_tables_3_4)

JoinedCampaign.create!(
  user: julien,
  campaign: campaign_restos_du_coeur_tables_3_4)

JoinedCampaign.create!(
  user: germain,
  campaign: campaign_restos_du_coeur_tables_3_4)

JoinedCampaign.create!(
  user: louis,
  campaign: campaign_restos_du_coeur_tables_3_4)

JoinedCampaign.create!(
  user: nicolas,
  campaign: campaign_restos_du_coeur_tables_3_4)

JoinedCampaign.create!(
  user: lylian,
  campaign: campaign_restos_du_coeur_tables_3_4)

JoinedCampaign.create!(
  user: chris,
  campaign: campaign_restos_du_coeur_tables_3_4)


puts "Created #{JoinedCampaign.all.size} joined campaign instances in seeds.rb"
