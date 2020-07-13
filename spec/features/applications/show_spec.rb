require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit an application show page' do

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

      visit "/pets/#{@pet_1.id}"

      within ".pets-#{@pet_1.id}" do
        click_on "Add To Favorites"
      end

      visit "/pets/#{@pet_2.id}"

      within ".pets-#{@pet_2.id}" do
        click_on "Add To Favorites"
      end

      visit '/favorites'
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      click_on "Apply to Adopt"

      expect(current_path).to eq("/applications/new")

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
    end

    it 'it shows a list of application details, including all pets this application is for' do

      visit "/applications/#{@pet_1.applications.first.id}"
      expect(page).to have_content("John")
      expect(page).to have_content("1050 Blake St")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80205")
      expect(page).to have_content("3037179808")
      expect(page).to have_content("I love animals.")
      expect(page).to have_content(@pet_1.name)
      page.has_link?(@pet_1.name)
    end

end
end
