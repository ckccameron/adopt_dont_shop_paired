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

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    shelter = Shelter.find(params[:shelter_id])
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      flash[:notice] = "You have edited your review!"
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = "Make sure you filled out the title, rating and content sections. Images are optional."
      redirect_to "/shelters/#{shelter.id}/reviews/#{@review.id}/edit"
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image, :shelter_id)
  end
end
