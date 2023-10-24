# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?

  protect_from_forgery with: :exception

  # before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource_or_scope)
    "/users/#{current_user.id}" if current_user.class != NilClass
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
