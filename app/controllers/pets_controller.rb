class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def pet_list
    @shelter_identifier = Shelter.find(params[:id])
    @shelter_pets = @shelter_identifier.pets
    @count = @shelter_pets.count
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    new_pet = Pet.create(pet_params)
    redirect_to("/shelters/#{new_pet.shelter_id}/pets")
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
      pet = Pet.find(params[:id])
      pet.update(pet_params)
      redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private
  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex, :shelter_id)
  end

end
