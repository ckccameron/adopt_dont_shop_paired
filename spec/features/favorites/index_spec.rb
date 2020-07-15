require 'rails_helper'

RSpec.describe "favorite index page" do
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

    within ".pets-#{@pet_1.id}" do
      click_on "Add To Favorites"
    end
  end

  it "displays all pets within favorites" do
    visit "/favorites"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_css("img[src='#{@pet_1.image}']")
  end

  it "provides link within favorites from pet's name to pet's show page" do
    visit "/favorites"

    click_on @pet_1.name
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).not_to have_content(@pet_2.name)
  end

  it "uses favorites indicator to link to favorites index" do
    visit "/favorites"

    click_on "Favorites: 1"
    expect(current_path).to eq("/favorites")
  end

  it "has a separate section that lists all pets that have an application on them, with a link to each pets show page" do

    visit "/pets/#{@pet_2.id}"

    within ".pets-#{@pet_2.id}" do
      click_on "Add To Favorites"
    end

    visit '/applications/new'

    within '.application_id' do
      within ".pets-#{@pet_1.id}" do
        check "pet_ids[]"
      end

      fill_in :name, with: 'John'
      fill_in :address, with: '1050 Blake St'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'CO'
      fill_in :zip, with: '80205'
      fill_in :phone_number, with: '3037179808'
      fill_in :description, with: 'I love animals.'
      click_button 'Submit Application'
    end

    expect(page.current_path).to eq('/favorites')

    within '.applied_for' do
      expect(page).to have_content(@pet_1.name)
    end
  end
end
