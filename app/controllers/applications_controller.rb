class ApplicationsController < ApplicationController

  def new
    @pets = favorite.favorite_pets
  end

  def create
    pets = Pet.where(id: applications_params[:pet_ids])
    Pet.transaction do

      application = Application.new(
        applications_params.except(:pet_ids)
      )
      pets.each do |pet|
        pet.applications << application
      end
    end
    redirect_to "/favorites", notice: 'Application created succesfully'
  rescue StandardError => e
    flash[:notice] = e.message
    redirect_to "/applications/new"
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def applications_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, pet_ids: [])
  end
end
