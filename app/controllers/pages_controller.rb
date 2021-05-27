require "open-uri"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :secret ]

  def home
  end

  def dashboard

    # private methods PERSONAL STATISTICS
    week_array_generation
    month_array_generation
    # private methods TEAM STATISTICS
    team_one_array_generation
    # private daily step
    daily_step
  end

  def donate
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @step_count = current_user.steps.where("date BETWEEN ? AND ?", @charity_event.date_beginning, @charity_event.date_ending).sum(:nb_steps)
    #define the status / ou filtre date
  end

  def secret

    JoinedTeam.destroy_all
    puts 'JT destroyed'
    Step.destroy_all
    puts 'steps destroyed'
    # User.destroy_all
    # puts 'users destroyed'
    Team.destroy_all
    puts 'teams destroyed'
    Campaign.destroy_all
    puts 'caamp destroyed'
    Enterprise.destroy_all
    puts 'enterp destroyed'
    CharityEvent.destroy_all
    puts 'ch ev destroyed'
    
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

    le_wagon = Enterprise.create!(name: "Le Wagon")


    puts "Created #{Enterprise.all.size} enterprises in seeds.rb"

    # CAMPAIGNS

    campaign_le_wagon = Campaign.create!(
      step_conversion: 0,
      max_contribution: 100000,
      charity_event: restos_du_coeur,
      enterprise: le_wagon
    )

    puts "Created #{Campaign.all.size} campaigns in seeds.rb"

    # USERS
    basil = User.all.where(email: "basil.lizotte@gmail.com").first
    arthur = User.all.where(email: "maguinarthur@gmail.com").first
    benjamin = User.all.where(email: "be.eycken@gmail.com").first
    maylis = User.all.where(email: "mdlmaylis@gmail.com").first

    # basil = User.create!(first_name: "Basil", last_name: "Lizotte", nickname: "lizottebasil", address: "4 rue Victor Masse", phone_number: "0675674509", email: "basil.lizotte@gmail.com", password: "123456", password_confirmation: "123456")

    # arthur = User.create!(first_name: "Arthur", last_name: "Maguin", nickname: "maguinarthur", address: "20 rue Victor Masse", phone_number: "0675674512", email: "maguinarthur@gmail.com", password: "123456", password_confirmation: "123456")

    # benjamin = User.create!(first_name: "Benjamin", last_name: "Eycken", nickname: "eyckenbenjamin", address: "20 rue Victor Masse", phone_number: "0675674512", email: "be.eycken@gmail.com", password: "123456", password_confirmation: "123456")

    # maylis = User.create!(first_name: "Maylis", last_name: "De La Monneraye", nickname: "dlmmaylis", address: "20 rue Victor Masse", phone_number: "0675674512", email: "mdlmaylis@gmail.com", password: "123456", password_confirmation: "123456")

    photo_basil = URI.open('./app/assets/images/basil.jpeg')
    basil.photo.attach(io: photo_basil, filename: 'basil_demo.jpg', content_type: 'image/jpg')

    photo_arthur = URI.open('./app/assets/images/arthur.jpeg')
    arthur.photo.attach(io: photo_arthur, filename: 'arthur_demo.jpg', content_type: 'image/jpg')

    photo_benjamin = URI.open('./app/assets/images/benjamin.jpeg')
    benjamin.photo.attach(io: photo_benjamin, filename: 'benjamin_demo.jpg', content_type: 'image/jpg')

    photo_maylis = URI.open('./app/assets/images/maylis.webp')
    maylis.photo.attach(io: photo_maylis, filename: 'maylis_demo.jpg', content_type: 'image/jpg')

    
    puts "Created #{User.all.size} users in seeds.rb"



    # STEPS

    def is_integer(number)
      number.floor == number
    end


    (3..30).each do |i|

      Step.create!(
      date: Date.parse("2021-05-#{i}") ,
      nb_steps: rand(1000..15000),
      week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
      user_id: basil.id)

      Step.create!(
      date: Date.parse("2021-05-#{i}") ,
      nb_steps: rand(1000..15000),
      week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
      user_id: arthur.id)

      Step.create!(
      date: Date.parse("2021-05-#{i}") ,
      nb_steps: rand(1000..15000),
      week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
      user_id: benjamin.id)

      Step.create!(
      date: Date.parse("2021-05-#{i}") ,
      nb_steps: rand(1000..15000),
      week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
      user_id: maylis.id)

    end

    puts "Created #{Step.all.size} steps instances for users in seeds.rb"


    # TEAMS

    uppla = Team.create!(
    name: "Un pas pour les autres",
    description: "The best team ever seen at the Wagon",
    campaign: campaign_le_wagon)

    Team.create!(
    name: "Gamer meets",
    description: "These guys are so lame",
    campaign: campaign_le_wagon)

    Team.create!(
    name: "Tinder for brands",
    description: "These guys are so lame",
    campaign: campaign_le_wagon)

    Team.create!(
    name: "Le plateau",
    description: "These guys are so lame",
    campaign: campaign_le_wagon)

    Team.create!(
    name: "Book society",
    description: "These guys are so lame",
    campaign: campaign_le_wagon)

    Team.create!(
    name: "Sound on",
    description: "These guys are so lame",
    campaign: campaign_le_wagon)


    puts "Created #{Team.all.size} team instances in seeds.rb"



    # JOINED TEAMS


    JoinedTeam.create!(
      user: arthur,
      team: uppla)

    JoinedTeam.create!(
      user: basil,
      team: uppla)

    JoinedTeam.create!(
      user: benjamin,
      team: uppla)

    JoinedTeam.create!(
      user: maylis,
      team: uppla)


    puts "Created #{JoinedTeam.all.size} joined team instances in seeds.rb"

    redirect_to root_path

  end


  private

  def daily_step
    # Daily step api fitness
    if current_user.steps.where( date: Date.today) != nil 
      today = current_user.steps.where( date: Date.today).first
      today.nb_steps = FitnessApi.new(current_user, current_user.token).get_daily_step
      today.save
    else
      Step.create!(user: current_user, nb_steps: FitnessApi.new(current_user, current_user.token).get_daily_step, date: Date.today)
    end
  end

  def week_array_generation
    @week_steps = []
    @week = current_user.steps.select { |ins| ins.date.cweek == Date.today.cweek }
    @week.each do |steps|
      @week_steps << [steps.date.strftime('%A'), steps.nb_steps]
    end
    @week_message = "Semaine du #{@week.first.date.strftime('%B %d, %Y')} au #{@week.last.date.strftime('%B %d, %Y')}"
  end

  def month_array_generation
    @month_steps = {}
    @month = current_user.steps.select { |ins| ins.date.month == Date.today.month }
    @month.each do |steps|
      @month_steps[steps.date.strftime('%F')] = steps.nb_steps
    end
    
    @month_message = "Mois de #{@month.first.date.strftime("%B %Y")}"

  end

  def team_one_array_generation
    @team_one_steps = []
    @team = current_user.teams.first.users
    @team.each do |member|
      @team_one_steps << ["#{member.first_name} #{member.last_name}", member.steps.where(date: Date.today).first.nb_steps]
    end
    @team_message = "Aujourd'hui"
  end

  def team_two_array_generation
  end

  def secret
    Step.destroy_all
    (3..30).each do |i|

      Step.create!(
      date: Date.parse("2021-05-#{i}") ,
      nb_steps: rand(1000..15000),
      week: (is_integer((i-3)/7) ? (i-3)/7 + 1 : ((i-3)/7).floor + 1),
      user_id: current_user.id)
    end
    redirect_to root_path
  end

  private

  def is_integer(number)
    number.floor == number
  end

end
