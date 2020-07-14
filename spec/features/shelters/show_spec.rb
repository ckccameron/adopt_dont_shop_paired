#shelters show spec
require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I visit a shelter show page' do
    it 'that shows the shelter information' do

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

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.address)
      expect(page).to_not have_content(shelter_2.address)
      expect(page).to have_content(shelter_1.name)
      expect(page).to_not have_content(shelter_2.name)
    end
  end

  it 'the shelter information includes statistics for the shelter, such as pet count, average shelter review rating, and number of applications.' do

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
    review_1 = Review.create!(title: "Decent Shelter",
                      rating: 2,
                      content: "I've seen bigger",
                      shelter_id: shelter_1.id)

    application_1 = Application.create(name: "John",
                                      address: "1050 Blake St",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80205",
                                      phone_number: "3037179808",
                                      description: "I love animals")

    PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)

    application_2 = Application.create(name: "Jim",
                                      address: "4444 First St",
                                      city: "Evergreen",
                                      state: "CO",
                                      zip: "80587",
                                      phone_number: "7209487562",
                                      description: "Cute pup")

    PetApplication.create(pet_id: pet_3.id, application_id: application_2.id)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.address)
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("Total Pets: 3")
    expect(page).to have_content("Average Review Rating: 3")
    expect(page).to have_content("Number of Applications: 2")
  end
end
