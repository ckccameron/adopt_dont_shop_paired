require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit my favorites page' do
    describe 'I see a link for adopting my favorite pets' do

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
      end



      it 'that takes me to a new application form' do

        visit '/favorites'
        expect(page).to have_content(@pet_1.name)
        click_on "Apply to Adopt"
        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Apply for your favorite pet!")

        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)

        within ".pets-#{@pet_1.id}" do
          check "pet_ids[]"
        end
      end

      it 'the application form has me fill out my name, address, city, state, zip, a description of why I would be a good owner. It also has me select which pets I would like to apply for.' do
        visit '/applications/new'

        expect do
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
        end.to change(Application, :count).and(change(PetApplication, :count))

        expect(page.current_path).to eq('/favorites')

        within '.show' do
          expect(page).to_not have_content(@pet_1.name)
        end

      end

      it 'if not all fields are filled out in the application, I am redirected back to the application page' do
        visit '/applications/new'

        expect do
          within '.application_id' do
            within ".pets-#{@pet_1.id}" do
              check "pet_ids[]"
            end
            fill_in :name, with: ''
            fill_in :address, with: '1050 Blake St'
            fill_in :city, with: 'Denver'
            fill_in :state, with: 'CO'
            fill_in :zip, with: '80205'
            fill_in :phone_number, with: '3037179808'
            fill_in :description, with: 'I love animals.'
            click_button 'Submit Application'
          end
        end.to_not change { Application.count }

        expect(page.current_path).to eq('/applications/new')

      end
    end
  end
end
