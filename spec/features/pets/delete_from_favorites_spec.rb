require 'rails_helper'

RSpec.describe "delete pet" do
  it "deletes pet from favorites when pet is deleted from database" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

    pet_1 =  Pet.create(name: "Winnie",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: true,
                        shelter_id: shelter_1.id)

    application_1 = Application.create(name: "John",
                                      address: "1050 Blake St",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80205",
                                      phone_number: "3037179808",
                                      description: "I love animals")

    PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)

    visit "/pets/#{pet_1.id}"

    within ".pets-#{pet_1.id}" do
      click_link "Add To Favorites"
    end

    visit "/pets/"

    click_link "Delete Winnie"

    expect(page).to have_content("Favorites: 0")
  end
end
