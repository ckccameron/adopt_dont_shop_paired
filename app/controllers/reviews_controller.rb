class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    new_review = Review.create(review_params)
    shelter.reviews << new_review
    redirect_to("/shelters/#{new_review.shelter_id}")
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image, :shelter_id)
  end
end
