class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    new_review = Review.create(review_params)
    shelter.reviews << new_review
    if new_review.valid?
      redirect_to("/shelters/#{new_review.shelter_id}")
    else
      flash[:errors] = "Please correctly fill out the form"
      redirect_to("/shelters/#{shelter.id}/reviews/new")
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image, :shelter_id)
  end
end
