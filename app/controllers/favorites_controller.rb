class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
  end
end
