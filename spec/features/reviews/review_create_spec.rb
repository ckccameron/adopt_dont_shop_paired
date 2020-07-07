require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the shelter show page' do
    describe 'I can follow a link to create a new review' do
      it 'then takes me to a form to fill out the information' do

      shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      pet_1 =  Pet.create!(name: "Winnie",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        shelter_id: shelter_1.id)

      review_1 = Review.create!(title: "Great Shelter",
                        rating: 4,
                        content: "All the pets looked really happy",
                        shelter_id: shelter_1.id)

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      click_on 'Write a Review'
      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
      fill_in :title, with: "Nice Shelter"
      #fill_in :rating, with: 4
      select 4
      fill_in :content, with: "Nice shelter, all the pets looked happy"
      fill_in :image, with: "https://imgur.com/r/puppies/NkpLnVJ"
      click_on "Submit Review"

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Nice Shelter")
      expect(page).to have_content("Nice shelter, all the pets looked happy")
      #add image
    end
    end
  end
end
