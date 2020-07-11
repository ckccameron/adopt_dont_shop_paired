require 'rails_helper'

RSpec.describe 'add pet to favorites' do
  before :each do
    @shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

    @pet_1 =  Pet.create!(name: "Winnie",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        shelter_id: @shelter_1.id)

    @pet_2 =  Pet.create(name: "Sir Maximus",
                        approximate_age: 1,
                        sex: "Male",
                        image: "https://imgur.com/r/puppies/JGDU9mi",
                        adoption_status: "Available",
                        shelter_id: @shelter_1.id)
  end

  it "favorites a pet and display message that pet was added" do
    visit "/pets/#{@pet_1.id}"

    within ".pets-#{@pet_1.id}" do
      click_on "Add To Favorites"
    end

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} was added to your favorites!")
  end

  it "displays total number of pets in favorites" do
    visit "/pets/#{@pet_1.id}"

    within ".pets-#{@pet_1.id}" do
      click_on "Add To Favorites"
    end

    visit "/pets/#{@pet_2.id}"

    within ".pets-#{@pet_2.id}" do
      click_on "Add To Favorites"
    end

    expect(page).to have_content("Favorites Count: 2")
  end
end
