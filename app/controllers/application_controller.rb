class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :count_new_notifs
  before_action :notifs
  
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :nickname, :phone_number])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :nickname, :phone_number])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def count_new_notifs
    if current_user
      if current_user.friend_requests_as_receiver.nil?
        return 0
      else
        return @count_new_notifs = current_user.friend_requests_as_receiver.where(status: :pending).count
      end
    end
  end

  def notifs
    if current_user
      if current_user.friend_requests_as_receiver.nil?
        return 0
      else
        return @notifs = current_user.friend_requests_as_receiver.where(status: :pending)
      end
    end
  end
end
