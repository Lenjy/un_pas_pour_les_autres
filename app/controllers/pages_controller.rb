class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    # private methods
    week_array_generation
    month_array_generation
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
    @month_message = "Mois de #{@month.first.date.strftime("%B %Y")}"
  end

end
