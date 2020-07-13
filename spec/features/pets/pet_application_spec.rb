require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit the pets show page' do
    describe 'there is a link to "View All Applications For This Pet"' do

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
        click_on "Apply to Adopt"

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

        visit '/favorites'
        click_on "Apply to Adopt"

        within '.application_id' do
          within ".pets-#{@pet_1.id}" do
            check "pet_ids[]"
          end
          fill_in :name, with: 'Anthony'
          fill_in :address, with: '457 Curtis St'
          fill_in :city, with: 'Denver'
          fill_in :state, with: 'CO'
          fill_in :zip, with: '80206'
          fill_in :phone_number, with: '3038763093'
          fill_in :description, with: 'Animals are the best.'
          click_button 'Submit Application'
        end
      end

      it 'shows the names of all applicants for that pet, with a link to the each application show page' do

        visit "/pets/#{@pet_1.id}"
        click_on "View all applications for #{@pet_1.name}"
        expect(current_path).to eq("/pets/#{@pet_1.id}/applications")

        page.has_link?("John")
        page.has_link?("Anthony")
        click_on "John"
        expect(current_path).to eq("/applications/#{@pet_1.applications.first.id}")


      end

    end
  end
end
