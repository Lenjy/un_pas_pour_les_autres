# require "open-uri"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :secret ]

  def home
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    # FAKE DATA BEFORE ENTERPRISE SEEDS ARE CREATED
    @top_companies = [[["# de pas - Entreprise", 1492], ["Donation en-cours", 300], ["# de pas moyen (employé", 300]], [["# de pas - Entreprise", 1692], ["Donation en-cours", 600], ["# de pas moyen (employé", 500]], [["# de pas - Entreprise", 1892], ["Donation en-cours", 800], ["# de pas moyen (employé)", 900]]]
    top_three_companies_generation
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
    date_to_check = Date.today
    @week = []
    7.times do
      @week << current_user.steps.where(date: date_to_check).first
      date_to_check = date_to_check.yesterday
    end
    @week.reverse!.each do |steps|
      @week_steps << [l(steps.date, format:"%A"), steps.nb_steps]
    end
    @week_message = "Semaine du #{I18n.l @week.first.date, format:"%d %B %Y"} au #{I18n.l @week.last.date, format:"%d %B %Y"}"
  end

  def month_array_generation
    @month_steps = {}
    @month = current_user.steps.select { |ins| ins.date.month == Date.today.month }
    @month.each do |steps|
      @month_steps[I18n.l steps.date, format:'%d %B'] = steps.nb_steps
    end

    @month_message = "#{I18n.l @month.first.date, format: "%B %Y"}".capitalize

  end

  def team_one_array_generation
    @team_one_steps = []
    @team = current_user.teams.first.users
    @team.each do |member|
      @team_one_steps << ["#{member.first_name} #{member.last_name}".html_safe, member.steps.where(date: Date.today).first.nb_steps]
    end
    @team_message = "Aujourd'hui, #{I18n.l Date.today, format:"%d %B %Y"}"
  end

  def team_two_array_generation
  end


  def top_three_companies_generation
    @top_three_companies_stats = []
    @sorted_companies = []
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @date_beginning = @charity_event.date_beginning
    @date_ending = @charity_event.date_ending
    Enterprise.all.each do |enterprise|
      sum_steps = enterprise.steps.where("? < date AND ? > date", @date_beginning, @date_ending).sum(:nb_steps)
      @sorted_companies << [["Entreprise instance", enterprise],
                               ["# de pas - Entreprise", sum_steps],
                               ["Donation en-cours", Campaign.where(enterprise_id: enterprise.id).first.max_contribution],
                               ["# de pas moyen (employé)", sum_steps / enterprise.users.count]]
    end
    @top_three_companies = @sorted_companies.sort! { |array| array[-1][-1]}.first(3)
  end

  def is_integer(number)
    number.floor == number
  end

end
