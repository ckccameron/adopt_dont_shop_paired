# pet delete from show spec

require 'rails_helper'

RSpec.describe 'When I visit the pet show page' do
  it "I can delete a pet out of the system" do

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

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content('Tom')

    click_link "Delete Pet"

    expect(current_path).to eq('/pets')
    expect(page).to_not have_content('Tom')
  end
end
