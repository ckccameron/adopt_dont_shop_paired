class FavoritesController < ApplicationController
  def index
    @pets = favorite.favorite_pets
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.favorite_already?(pet.id)
    session[:favorite] = favorite.contents
    flash[:notice] = "#{pet.name} was added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite.remove_pet(pet.id)
    flash[:notice] = "#{pet.name} was removed from your favorites"
    redirect_to "/favorites"
  end
end
