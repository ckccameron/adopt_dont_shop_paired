class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    Shelter.create(shelter_params)
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    arr = []
    shelter.pets.each do |pet|
      list = PetApplication.where("pet_id = ?", pet.id).where("status = ?", true)
      unless list.empty?
        arr << list
      end
    end
    if arr.empty?
      shelter.pets.each do |pet|
        PetApplication.where("pet_id = ?", pet.id).destroy_all
        Pet.delete(pet.id)
      end
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    else
      flash[:notice] = "#{shelter.name} cannot be deleted while applications are approved."
      redirect_to "/shelters"
    end
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
