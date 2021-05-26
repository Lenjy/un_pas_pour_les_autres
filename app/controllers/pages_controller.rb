class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

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
  end

  def donate
    @charity_event = CharityEvent.where("? BETWEEN date_beginning AND date_ending", Time.zone.now).last
    @step_count = current_user.steps.where("date BETWEEN ? AND ?", @charity_event.date_beginning, @charity_event.date_ending).sum(:nb_steps)
    #define the status / ou filtre date

  end

end
