class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :add_favorite_count

  def add_favorite_count
    @favorites = Pet.where(favorite_status: true).count
  end
end
