require 'rails_helper'

RSpec.describe "application show page" do
  it "can approve applications for pets" do
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

    application_1 = Application.create(name: "John",
                                      address: "1050 Blake St",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80205",
                                      phone_number: "3037179808",
                                      description: "I love animals")

    pet_application_1 = PetApplication.create(pet_id: pet_1.id,
                                              application_id: application_1.id)


    visit "/applications/#{application_1.id}"

    within ".pets-#{pet_1.id}" do
      click_on "Approve Adoption"
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("On hold for John")
  end
end

# As a visitor
# When I visit an application's show page
# For every pet that the application is for, I see a link to approve the application for that specific pet
# When I click on a link to approve the application for one particular pet
# I'm taken back to that pet's show page
# And I see that the pets status has changed to 'pending'
# And I see text on the page that says who this pet is on hold for (Ex: "On hold for John Smith", given John Smith is the name on the application that was just accepted)
