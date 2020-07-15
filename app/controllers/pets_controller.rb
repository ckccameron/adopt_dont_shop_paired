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
    unfilled_params = pet_params.select{|param, value| value.empty?}
    shelter = Shelter.find(params[:shelter_id])
    if !unfilled_params.empty?
      flash[:notice] = "Please fill in #{unfilled_params.keys.join(", ")} to create a pet"
      redirect_back(fallback_location: "/shelters/#{shelter.id}/pets/new")
    else
      shelter.pets.create(pet_params)
      redirect_to("/shelters/#{shelter.id}/pets")
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
      pet = Pet.find(params[:id])
      pet.update!(pet_params)
      redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.adoption_status == true
      favorite.remove_pet(pet.id)
      Pet.destroy(params[:id])
      redirect_to "/pets"
    end
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex, :shelter_id)
  end

end
