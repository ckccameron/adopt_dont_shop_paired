# create pet spec

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the shelter pet index page' do
    describe 'I can follow a link to create a new pet' do
      it 'then takes me to a form to fill out the information' do

        shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                          address: "3301 Navajo Street",
                          city: "Denver",
                          state: "CO",
                          zip: 80021)
        shelter_2 = Shelter.create!(name: "Monterey Animal Shelter",
                          address: "2520 Crimson Road",
                          city: "Monterey",
                          state: "CA",
                          zip: 35872)

        pet_1 =  Pet.create!(name: "Tom",
                          approximate_age: 3,
                          sex: "Female",
                          image: "https://imgur.com/r/puppies/cYqJGNo",
                          adoption_status: "Available",
                          description: "Simply the best",
                          shelter_id: shelter_1.id)
        pet_2 =  Pet.create!(name: "Sir Maximus",
                          approximate_age: 1,
                          sex: "Male",
                          image: "https://imgur.com/r/puppies/JGDU9mi",
                          adoption_status: "Available",
                          shelter_id: shelter_2.id)

        visit "/shelters/#{shelter_1.id}/pets"

        expect(page).to have_content(pet_1.name)
        expect(page).to_not have_content(pet_2.name)

        click_on 'Create Pet'
        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")
        fill_in :name, with: "Birdie"
        fill_in :image, with: "https://imgur.com/r/puppies/NkpLnVJ"
        fill_in :description, with: "The cutest!"
        fill_in :approximate_age, with: 2
        select "Female"
        click_on "Create Pet"

        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
        expect(page).to have_content("Birdie")
        expect(page).to have_content("Tom")
        expect(page).to_not have_content("Sir Maximums")
    end
  end
end
end
