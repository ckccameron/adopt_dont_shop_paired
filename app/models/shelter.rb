class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def total_pets
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def total_applications
    pets.reduce(0) {|sum, pet_app| sum + pet_app.applications.count }
  end

end
