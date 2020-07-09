require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a pets show page' do
    describe 'I can click a Favorite button' do
      xit 'will add the pet to my list of favorites' do

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

      visit "/pets/#{pet_1.id}"

      expect(page).to have_content("Favorites Count: 0")
      expect(page).to have_button("Add to Favorites")
      click_on "Add to Favorites"

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_content("Favorites Count: 1")
      expect(page).to have_content("Pet has been added to your favorites!")
    end 
    end
  end
end
