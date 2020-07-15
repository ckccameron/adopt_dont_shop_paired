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

      pet_1 =  Pet.create!(name: "Winnie",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        description: "Simply the best",
                        shelter_id: shelter_1.id)


      visit "pets/#{pet_1.id}"

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.adoption_status)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.approximate_age)

    end
  end
end
