require 'rails_helper'

RSpec.describe "remove pet from favorites" do
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
  end

  it "allows user to remove pet witin favorites index page" do
    visit "/pets/#{@pet_1.id}"

    within ".pets-#{@pet_1.id}" do
      click_on "Add To Favorites"
    end

    visit "/favorites"
    expect(page).to have_content("Favorites: 1")

    click_on "Remove Favorite"
    expect(page).to have_content("#{@pet_1.name} was removed from your favorites")
    expect(page).to have_content("Favorites: 0")
  end
end
