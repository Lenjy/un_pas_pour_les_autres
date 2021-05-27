class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :secret ]

  def home
  end

  def dashboard
    @week_steps = []
    # La semaine est fixe ! Il faut rendre la semaine dynamique
    current_user.steps.where(week: 1).each do |steps|
      @week_steps << [steps.date.strftime('%A'), steps.nb_steps]
    end
    # Pareil pour le mois
    @month_steps = {}
    current_user.steps.each do |steps|
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
    raise
  end

  def donate
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @step_count = current_user.steps.where("date BETWEEN ? AND ?", @charity_event.date_beginning, @charity_event.date_ending).sum(:nb_steps)
    #define the status / ou filtre date

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
