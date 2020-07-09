class Pets::FavoritesController < ApplicationController

  def update
    @pet = Pet.find(params[:id])
    new_status = @pet.favorite_status ? false : true
    @pet.update(favorite_status: new_status)
    flash[:notice] = "#{@pet.name} has been added to your Favorites"
    redirect_to "/pets/#{@pet.id}"
  end
end
