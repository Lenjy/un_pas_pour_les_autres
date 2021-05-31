# require "open-uri"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :secret ]

  def home
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last

    @charity_events_past = CharityEvent.where("date_ending < ?", Time.zone.now).order(date_ending: :desc)
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

  def is_integer(number)
    number.floor == number
  end

end
