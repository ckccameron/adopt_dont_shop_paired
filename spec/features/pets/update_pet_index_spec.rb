require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the pet index page' do
    describe 'I can follow a link to update a pet' do
      it 'then takes me to a form to edit the information' do
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

        visit "/pets/"

        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_2.name)

        click_on 'Update Tom'
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")
        fill_in :name, with: "Winnie the Poo"
        select "Male"
        click_on "Update Pet"

        expect(current_path).to eq("/pets/#{pet_1.id}")
        expect(page).to have_content("Winnie the Poo")
        expect(page).to have_content("Male")
        expect(page).to_not have_content("Tom")
      end
    end
  end

  describe 'when I visit the shelter pet index page' do
    describe 'I can follow a link to update a pet' do
      it 'then takes me to a form to edit the information' do

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

        click_on 'Update Tom'
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")
        fill_in :name, with: "Winnie the Poo"
        select "Male"
        click_on "Update Pet"

        expect(current_path).to eq("/pets/#{pet_1.id}")
        expect(page).to have_content("Winnie the Poo")
        expect(page).to have_content("Male")
        expect(page).to_not have_content("Female")
      end

      it "shows flash message indicating specific text field that user didn't fill in" do
        shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                          address: "3301 Navajo Street",
                          city: "Denver",
                          state: "CO",
                          zip: 80021)

        pet_1 =  Pet.create!(name: "Tom",
                            approximate_age: 3,
                            sex: "Female",
                            image: "https://imgur.com/r/puppies/cYqJGNo",
                            adoption_status: "Available",
                            description: "Simply the best",
                            shelter_id: shelter_1.id)

        visit "/shelters/#{shelter_1.id}/pets"

        click_on "Update Tom"

        fill_in :name, with: ""
        fill_in :image, with: "https://imgur.com/r/puppies/cYqJGNo"
        fill_in :description, with: "Simply the best"
        fill_in :approximate_age, with: 3
        select "Female"
        click_on "Update Pet"

        expect(current_path).to eq("/pets/#{pet_1.id}/edit")
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
