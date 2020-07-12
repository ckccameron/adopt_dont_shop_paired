class ApplicationsController < ApplicationController

  def new
    @pets = favorite.favorite_pets
  end

  def create
    pets = Pet.where(id: applications_params[:pet_ids])
    Pet.transaction do
      pets.each do |pet|
        application = Application.new(
          applications_params.except(:pet_ids)
        )
        pet.applications << application
      #  session[:favorite].delete(pet.id.to_s)
      end
    end
    redirect_to "/favorites", notice: 'Application created succesfully'
  rescue StandardError => e
    flash[:notice] = e.message
    redirect_to "/applications/new"
  end

  private

  def applications_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, pet_ids: [])
  end

end
