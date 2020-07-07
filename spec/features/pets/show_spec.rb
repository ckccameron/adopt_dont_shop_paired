#pets show spec

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I visit a pet show page' do
    it 'shows the attributes of that pet' do

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

      pet_1 =  Pet.create!(name: "Winnie",
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

      visit "pets/#{pet_1.id}"

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.adoption_status)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to_not have_content(pet_2.name)
      expect(page).to_not have_content(pet_2.approximate_age)
    end
  end
end
