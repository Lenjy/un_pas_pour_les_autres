class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]
  skip_after_action :verify_authorized, only: [:search]

  def index
    if params[:query].present?
      @users = policy_scope(User).search_by_full_name(params[:query])
    else
      @users = policy_scope(User)
    end
  end

  def search
    if params[:query].present?
      @users = policy_scope(User).search_by_full_name(params[:query])
    end
    respond_to do |format|
      format.json { render json: { html: render_to_string(partial: 'users/user_list.html', formats: :html, locals: {users: @users})}}
    end
  end

  def show
    # if current_user.steps.where( date: Date.today) != nil
    #   current_user.steps.where( date: Date.today).nb_steps = FitnessApi.new(current_user, current_user.token).get_daily_step
    #   current_user.steps.where( date: Date.today).save
    # else
    #   Step.create!(user: current_user, nb_steps: FitnessApi.new(current_user, current_user.token).get_daily_step, date: Date.today)
    # end
    @user = User.find(params[:id])
    @friend_request = FriendRequest.new(receiver_id: @user.id)
    authorize @user
    # private methods PERSONAL STATISTICS
    week_array_generation
    month_array_generation
    previous_month_array_generation
    get_donation_event
    # private methods TEAM STATISTICS
    team_one_array_generation
    if !current_user.nil?
      @receiver = current_user.friend_requests_as_receiver.where(asker_id: @user.id)
      @asker = current_user.friend_requests_as_asker.where(receiver_id: @user.id)
    end
  end

  private

  def week_array_generation
    @week_steps = []
    date_to_check = Date.today
    @week = []
    7.times do
      @week << @user.steps.where(date: date_to_check).first
      date_to_check = date_to_check.yesterday
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
      6.times do
        date_tmp = date_tmp.yesterday
      end
      @week_message = "Semaine du 29 mai au 4 juin "
    else
      @week_message = "Semaine du 29 mai au 4 juin "
    end
  end

  def month_array_generation
    @month_steps = {}
    @month = @user.steps.select { |ins| ins.date.month == Date.today.month }
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
    @previous_month = @user.steps.select { |ins| ins.date.month == Date.today.prev_month.month }
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
    @team = @user.teams.first.users
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

  def is_integer(number)
    number.floor == number
  end

  def get_donation_event
    # @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @charity_event = CharityEvent.last
    @all_steps_events = @user.steps.select{ |step| step.date > @charity_event.date_beginning}.select{ |step| step.date < @charity_event.date_ending}
    @sum_steps = @all_steps_events.sum{|step| step.nb_steps}
    @donation_events = @sum_steps * 0.0005
    if @user.donation_payment_ids != []
      @user.donation_payment_ids.each do |dons|
        @donation_events += dons
      end
    end
    # attention pas dynamique pour la suite, il faut pas faire .first mais .where
    if @donation_events != @user.joined_campaigns.first.user_donation_event
      campagne = @user.joined_campaigns.first
      campagne.user_donation_event = @donation_events
      campagne.save!
    end
  end

end
