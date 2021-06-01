# require "open-uri"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :secret ]

  def home
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    # FAKE DATA BEFORE ENTERPRISE SEEDS ARE CREATED
    # @top_companies = [[["# de pas - Entreprise", 1492], ["Donation en-cours", 300], ["# de pas moyen (employé", 300]], [["# de pas - Entreprise", 1692], ["Donation en-cours", 600], ["# de pas moyen (employé", 500]], [["# de pas - Entreprise", 1892], ["Donation en-cours", 800], ["# de pas moyen (employé)", 900]]]
    # top_three_companies_generation
    # top_three_walkers_generation
    # top_three_teams_generation
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
    if current_user.steps.where( date: Date.today) != nil
      7.times do
        @week << current_user.steps.where(date: date_to_check).first
        date_to_check = date_to_check.yesterday
      end
    else
      fictional_date = Step.create!(user: current_user, nb_steps: FitnessApi.new(current_user, current_user.token).get_daily_step, date: Date.today)
      7.times do
        @week << current_user.steps.where(date: fictional_date).first
        fictional_date = fictional_date.yesterday
      end
    end
    @week.reverse!.each do |steps|
      if steps.nil?
        @week_steps << [l(date_to_check, format:"%A"), 0]
      else
        @week_steps << [l(steps.date, format:"%A"), steps.nb_steps]
      end
      date_to_check = date_to_check.next_day
    end
    if @week.last.nil?
      @week_message = "Semaine du #{I18n.l @week.first.date, format:"%d %B %Y"} au #{I18n.l Date.today, format:"%d %B %Y"}"
    elsif
      date_tmp = Date.today
      6.times do
        date_tmp = date_tmp.yesterday
      end
      @week_message = "Semaine du #{I18n.l @week.first.date, format:"%d %B %Y"} au #{I18n.l date_tmp, format:"%d %B %Y"}"
    else
      @week_message = "Semaine du #{I18n.l @week.first.date, format:"%d %B %Y"} au #{I18n.l @week.last.date, format:"%d %B %Y"}"
    end
  end

  def month_array_generation
    @month_steps = {}
    @month = current_user.steps.select { |ins| ins.date.month == Date.today.month }
    @month = @month.sort_by { |ins| ins.date }
    @month.each do |steps|
      @month_steps[I18n.l steps.date, format:'%d %B'] = steps.nb_steps
    end

    @month_message = "#{I18n.l @month.first.date, format: "%B %Y"}".capitalize

  end

  def team_one_array_generation
    @team_one_steps = []
    @team = current_user.teams.first.users
    @team.each do |member|
      if member.steps.where(date: Date.today) == []
        @team_one_steps << ["#{member.first_name} #{member.last_name}".html_safe, 0 ]
      else
        @team_one_steps << ["#{member.first_name} #{member.last_name}".html_safe, member.steps.where(date: Date.today).first.nb_steps]
      end
    end
    @team_message = "Aujourd'hui, #{I18n.l Date.today, format:"%d %B %Y"}"
  end

  def team_two_array_generation
  end


  def top_three_companies_generation
    sorted_companies = []
    charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    date_beginning = charity_event.date_beginning
    date_ending = charity_event.date_ending
    Enterprise.all.each do |enterprise|
      sum_steps = enterprise.steps.where("? < date AND ? > date", date_beginning, date_ending).sum(:nb_steps)
      sorted_companies << [["Entreprise instance", enterprise],
                            ["# de pas - Entreprise", sum_steps],
                            ["Donation en-cours", Campaign.where(enterprise_id: enterprise.id).first.max_contribution],
                            ["# de pas moyen (employé)", sum_steps / enterprise.users.count]]
    end
    @top_three_companies = sorted_companies.sort_by! { |array| array[-1][-1]}.first(3).reverse
  end

  def top_three_walkers_generation
    sorted_walkers = []
    charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    date_beginning = charity_event.date_beginning
    date_ending = charity_event.date_ending
    User.all.each do |user|
      joined_campaign = JoinedCampaign.where("? = user_id AND ? = campaign_id", user.id, user.enterprise.campaigns.where(charity_event: charity_event).first.id).first
      sum_steps = user.steps.where("? < date AND ? > date", date_beginning, date_ending).sum(:nb_steps)
      sorted_walkers << [["User instance", user],
                         ["# de pas totaux", sum_steps],
                         ["Donation en-cours", joined_campaign.user_donation_event + joined_campaign.conversion_enterprise_donation]]
    end
    @top_three_walkers = sorted_walkers.sort_by! { |array| array[1][-1]}.first(3).reverse
  end

  def top_three_teams_generation
    @sorted_teams = []
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @date_beginning = @charity_event.date_beginning
    @date_ending = @charity_event.date_ending
    Team.all.each do |team|
      sum_steps = team.steps.where("? < date AND ? > date", @date_beginning, @date_ending).sum(:nb_steps)
      team_donation = 0
      team.users.each do |user|
        joined_campaign = JoinedCampaign.where("? = user_id AND ? = campaign_id", user.id, user.enterprise.campaigns.where(charity_event: @charity_event).first.id).first
        team_donation += joined_campaign.user_donation_event + joined_campaign.conversion_enterprise_donation
      end
      @sorted_teams << [["Team instance", team],
                       ["# de pas - Team", sum_steps],
                       ["Donation en-cours", team_donation]]
    end
    @top_three_teams = @sorted_teams.sort_by! { |array| array[1][-1]}.first(3).reverse
  end

  def is_integer(number)
    number.floor == number
  end

end
