require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'There is a navbar feature' do
    it 'shows my count of favorite pets' do

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
                        favorite_status: true,
                        shelter_id: shelter_1.id)

      visit "/shelters"
      expect(page).to have_content("Favorites Count: 1")
    end
  end
end
