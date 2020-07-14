require 'rails_helper'

RSpec.describe "application show page" do
  it "can approve applications for pets" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

    pet_1 =  Pet.create(name: "Winnie",
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

    PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)


    visit "/applications/#{application_1.id}"

    within ".pets-#{pet_1.id}" do
      click_on "Approve Adoption"
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("On hold for John")
  end

  it "can approve multiple pets for a single user" do
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

    pet_2 =  Pet.create(name: "Sir Maximus",
                      approximate_age: 1,
                      sex: "Male",
                      image: "https://imgur.com/r/puppies/JGDU9mi",
                      adoption_status: true,
                      shelter_id: shelter_1.id)

    pet_3 =  Pet.create(name: "Benny",
                      approximate_age: 5,
                      sex: "Male",
                      image: "https://imgur.com/r/puppies/JGDU9mi",
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

    PetApplication.create(pet_id: pet_2.id, application_id: application_1.id)

    PetApplication.create(pet_id: pet_3.id, application_id: application_1.id)

    visit "/applications/#{application_1.id}"

    within ".pets-#{pet_1.id}" do
      click_on "Approve Adoption"
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("On hold for John")

    visit "/applications/#{application_1.id}"

    within ".pets-#{pet_2.id}" do
      click_on "Approve Adoption"
    end

    expect(current_path).to eq("/pets/#{pet_2.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("On hold for John")

    visit "/applications/#{application_1.id}"

    within ".pets-#{pet_3.id}" do
      click_on "Approve Adoption"
    end

    expect(current_path).to eq("/pets/#{pet_3.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("On hold for John")
  end

  it "only allows pet to have one approved application on them" do
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

    application_2 = Application.create(name: "Joe",
                                      address: "2045 Yosemite St",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80231",
                                      phone_number: "3034882020",
                                      description: "I enjoy going on walks and I'd bring my new friend with me all the time")

    PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)
    PetApplication.create(pet_id: pet_1.id, application_id: application_2.id)

    visit "/applications/#{application_1.id}"

    within ".pets-#{pet_1.id}" do
      click_on "Approve Adoption"
    end

    visit "/applications/#{application_2.id}"

    within ".pets-#{pet_1.id}" do
      click_on "Approve Adoption"
    end

    expect(page).to have_content("No more applications can be approved for Winnie at this time")
  end

  it "can revoke applications that have been approved" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

    pet_1 =  Pet.create(name: "Winnie",
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

    PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)

    visit "/applications/#{application_1.id}"

    within ".pets-#{pet_1.id}" do
      click_on "Approve Adoption"
    end

    visit "/applications/#{application_1.id}"

    expect(page).not_to have_link("Approve Adoption")

    within ".pets-#{pet_1.id}" do
      click_on "Revoke Adoption Approval"
    end

    expect(current_path).to eq("/applications/#{application_1.id}")

    within ".pets-#{pet_1.id}" do
      expect(page).to have_link("Approve Adoption")
    end

    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("Adoptable")
    expect(page).not_to have_content("Pending")
    expect(page).not_to have_content("On hold for John")
  end
end
