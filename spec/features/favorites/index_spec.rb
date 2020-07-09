require 'rails_helper'

RSpec.describe "favorite a pet" do
  before :each do
    @shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                                address: "3301 Navajo Street",
                                city: "Denver",
                                state: "CO",
                                zip: 80021)

    @shelter_2 = Shelter.create!(name: "Monterey Animal Shelter",
                                address: "2520 Crimson Road",
                                city: "Monterey",
                                state: "CA",
                                zip: 35872)

    @pet_1 =  Pet.create(name: "Winnie",
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
                        shelter_id: @shelter_2.id)

    visit "/pets/#{@pet_1.id}"
  end

  it "allows user to click on favorites indicator to go to favorites" do
    visit "/favorites"
    click_on "Favorites"
    expect(current_path). to eq("/favorites")
  end
end




# As a visitor
# When I visit a pet's show page
# I see a button or link to favorite that pet
# When I click the button or link
# I'm taken back to that pet's show page
# I see a flash message indicating that the pet has been added to my favorites list
# The favorite indicator in the nav bar has incremented by one
