class UsersController < ApplicationController
  before_action :authenticate_user!
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
    # private methods TEAM STATISTICS
    team_one_array_generation
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
      @week_message = "Semaine du #{I18n.l Date.today - 7, format:"%d %B %Y"} au #{I18n.l Date.today, format:"%d %B %Y"}"
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


end
