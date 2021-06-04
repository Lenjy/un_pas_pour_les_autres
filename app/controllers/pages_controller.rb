# require "open-uri"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :secret ]

  def home
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @charity_events_past = CharityEvent.where("date_ending < ?", Time.zone.now).order(date_ending: :desc)
    top_three_companies_generation
    top_three_walkers_generation
    # top_three_teams_generation
  end

  def dashboard
    week_array_generation
    month_array_generation
    previous_month_array_generation
    team_one_array_generation
    daily_step
    set_friend_requests
    get_donation_event
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
    if current_user.steps.where( date: Date.today) != []
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
    if current_user.steps.where( date: Date.today) != []
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
    if @week.last.nil? && @week.first.nil?
      # @week_message = "Semaine du #{I18n.l Date.today - 7, format:"%d %B %Y"} au #{I18n.l Date.today, format:"%d %B %Y"}"
      @week_message = "Semaine du 29 mai au 4 juin "
    elsif
      date_tmp = Date.today
      4.times do
        date_tmp = date_tmp.yesterday
      end
      @week_message = "Semaine du 29 mai au 4 juin "
      # @week_message = "Semaine du #{I18n.l @week.first.date, format:"%d %B %Y"} au #{I18n.l date_tmp, format:"%d %B %Y"}"
    else
      @week_message = "Semaine du 29 mai au 4 juin "
      # @week_message = "Semaine du #{I18n.l @week.first.date, format:"%d %B %Y"} au #{I18n.l @week.last.date, format:"%d %B %Y"}"
    end
  end

  def month_array_generation
    @month_steps = {}
    @month = current_user.steps.select { |ins| ins.date.month == Date.today.month }
    @month = @month.sort_by { |ins| ins.date }
    @month.each do |steps|
      @month_steps[I18n.l steps.date, format:'%d %B'] = steps.nb_steps
    end
    if @month == []
      @month_message = "#{I18n.l Date.today, format: "%B %Y"}".capitalize
    else
      @month_message = "#{I18n.l @month.first.date, format: "%B %Y"}".capitalize
    end

  end

  def previous_month_array_generation
    @previous_month_steps = {}
    @previous_month = current_user.steps.select { |ins| ins.date.month == Date.today.prev_month.month }
    @previous_month = @previous_month.sort_by { |ins| ins.date }
    @previous_month.each do |steps|
      @previous_month_steps[I18n.l steps.date, format:'%d %B'] = steps.nb_steps
    end
    if @previous_month == []
      @previous_month_message = "#{I18n.l Date.today, format: "%B %Y"}".capitalize
    else
      @previous_month_message = "#{I18n.l @previous_month.first.date, format: "%B %Y"}".capitalize
    end

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
    @sorted_companies = []
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @date_beginning = @charity_event.date_beginning
    @date_ending = @charity_event.date_ending
    Enterprise.all.each do |enterprise|
      sum_steps = enterprise.steps.where("? < date AND ? > date", @date_beginning, @date_ending).sum(:nb_steps)
      if enterprise.users == []
        @sorted_companies << [["Entreprise instance", enterprise],
                            ["Ratio pas / employé", 0],
                            ["Total de pas", 0]]
      else
        @sorted_companies << [["Entreprise instance", enterprise],
                              ["Ratio pas / employé", sum_steps / enterprise.users.count],
                              ["Total de pas", sum_steps]]
      end
    end
    @top_three_companies = @sorted_companies.sort_by! { |array| array[1][-1]}.first(3).reverse
    @max_company = @top_three_companies.map {|element| element.last(1).flatten}.map(&:last).max
    @rounded_max_company = (@max_company / 10000 + 1).round * 10000
  end

  def top_three_walkers_generation
    @sorted_walkers = []
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @date_beginning = @charity_event.date_beginning
    @date_ending = @charity_event.date_ending
    User.all.each do |user|
      joined_campaign = JoinedCampaign.where("? = user_id AND ? = campaign_id", user.id, user.enterprise.campaigns.where(charity_event: @charity_event).first.id).first
      sum_steps = user.steps.where("? < date AND ? > date", @date_beginning, @date_ending).sum(:nb_steps)
      @sorted_walkers << [["User instance", user],
                         ["Total de pas", sum_steps],
                         ["Dons", joined_campaign.user_donation_event]]
    end
    @top_three_walkers = @sorted_walkers.sort_by! { |array| array[1][-1]}.last(3).reverse
    @max_walker = @top_three_walkers.map {|element| element[1].flatten}.map(&:last).max
    @rounded_max_walker = (@max_walker / 10000 + 1).round * 10000
  end

  # def top_three_teams_generation
  #   @sorted_teams = []
  #   @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
  #   @date_beginning = @charity_event.date_beginning
  #   @date_ending = @charity_event.date_ending
  #   Team.all.each do |team|
  #     sum_steps = team.steps.where("? < date AND ? > date", @date_beginning, @date_ending).sum(:nb_steps)
  #     team_donation = 0
  #     team.users.each do |user|
  #       joined_campaign = JoinedCampaign.where("? = user_id AND ? = campaign_id", user.id, user.enterprise.campaigns.where(charity_event: @charity_event).first.id).first
  #       team_donation += joined_campaign.user_donation_event + joined_campaign.conversion_enterprise_donation
  #     end
  #     @sorted_teams << [["Team instance", team],
  #                      ["# de pas - Team", sum_steps],
  #                      ["Donation en-cours", team_donation]]
  #   end
  #   @top_three_teams = @sorted_teams.sort_by! { |array| array[1][-1]}.last(3).reverse
  # end

  def is_integer(number)
    number.floor == number
  end

  def set_friend_requests
    @pending_friend_requests = current_user.friend_requests_as_receiver.where(status: :pending)
    @accepted_friend_requests_received = current_user.friend_requests_as_receiver.where(status: :accepted)
    @accepted_friend_requests_sent = current_user.friend_requests_as_asker.where(status: :accepted)
  end

  def get_donation_event
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @all_steps_events = current_user.steps.select{ |step| step.date > @charity_event.date_beginning}.select{ |step| step.date < @charity_event.date_ending}
    @sum_steps = @all_steps_events.sum{|step| step.nb_steps}
    @donation_events = @sum_steps * 0.0005
    if current_user.donation_payment_ids != []
      current_user.donation_payments.each do |dons|
        @donation_events = @donation_events + ( dons.amount_cents / 100 )
      end
    end
    # attention pas dynamique pour la suite, il faut pas faire .first mais .where
    if @donation_events != current_user.joined_campaigns.first.user_donation_event
      campagne = current_user.joined_campaigns.first
      campagne.user_donation_event = @donation_events
      campagne.save!
    end
  end
end
