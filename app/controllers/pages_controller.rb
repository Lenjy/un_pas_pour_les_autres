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
  end

  def donate
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @step_count = current_user.steps.where("date BETWEEN ? AND ?", @charity_event.date_beginning, @charity_event.date_ending).sum(:nb_steps)
    #define the status / ou filtre date

  end

  private

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

    # Daily step api fitness
    if current_user.steps.where( date: Date.today) != nil 
      today = current_user.steps.where( date: Date.today).first
      today.nb_steps = FitnessApi.new(current_user, current_user.token).get_daily_step
      today.save
    else
      Step.create!(user: current_user, nb_steps: FitnessApi.new(current_user, current_user.token).get_daily_step, date: Date.today)
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
