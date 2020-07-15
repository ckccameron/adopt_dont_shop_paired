class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    # pet_app = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:application_id])
    application = Application.find(params[:application_id])
    if pet.adoption == "Pending"
      flash[:notice] = "No more applications can be approved for #{pet.name} at this time"
      redirect_to "/pets/#{pet.id}"
    else
      pet.adoption = "Pending"
      pet.save
      application.status = "Approved"
      application.save
      redirect_to "/pets/#{pet.id}"
    end
  end
end
