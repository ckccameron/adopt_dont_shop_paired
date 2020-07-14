require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click on the delete button by the shelter on the index page' do
    it 'then the shelter is deleted, and the index page is refreshed' do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)
      shelter_2 = Shelter.create!(name: "Monterrey Animal Shelter",
                        address: "2520 Crimson Road",
                        city: "Monterey",
                        state: "CA",
                        zip: 35872)

      visit '/shelters'
      expect(page).to have_content(shelter_2.name)
      click_on 'Delete Monterrey Animal Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(shelter_2.name)
      expect(page).to have_content(shelter_1.name)
    end

  it 'if a shelter has pets (of which none are approved for adoption), then all pets AND all reviews will be deleted if the shelter is deleted' do

    shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                      address: "3301 Navajo Street",
                      city: "Denver",
                      state: "CO",
                      zip: 80021)
    shelter_2 = Shelter.create!(name: "Monterrey Animal Shelter",
                      address: "2520 Crimson Road",
                      city: "Monterey",
                      state: "CA",
                      zip: 35872)

    pet_1 =  Pet.create!(name: "Winnie",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        shelter_id: shelter_1.id)

    pet_2 =  Pet.create(name: "Sir Maximus",
                      approximate_age: 1,
                      sex: "Male",
                      image: "https://imgur.com/r/puppies/JGDU9mi",
                      adoption_status: "Available",
                      shelter_id: shelter_1.id)

    pet_3 =  Pet.create(name: "Benny",
                      approximate_age: 5,
                      sex: "Male",
                      image: "https://imgur.com/r/puppies/JGDU9mi",
                      adoption_status: "Available",
                      shelter_id: shelter_1.id)

    review_1 = Review.create!(title: "Great Shelter",
                      rating: 4,
                      content: "All the pets looked really happy",
                      shelter_id: shelter_1.id)

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_content(shelter_1.name)
      visit '/shelters'
      expect(page).to have_content(shelter_1.name)
      click_on "Delete #{shelter_1.name}"

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      visit "/pets"
      expect(page).to_not have_content(pet_1.name)
    end
  end
end
