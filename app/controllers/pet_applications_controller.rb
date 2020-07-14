class PetApplicationsController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:application_id])
    pet.adoption = "Pending"
    application.status = "Approved"
    pet.save
    application.save

    redirect_to "/pets/#{pet.id}"
  end
end
