#shelter delete from show page

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click on the delete button by the shelter on the show page' do
    it 'then the shelter is deleted, and I am redirected to the shelter index page' do

      shelter_1 =  Shelter.create!(name: "Aurora Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)
      shelter_2 = Shelter.create!(name: "Monterey Animal Shelter",
                        address: "2520 Crimson Road",
                        city: "Monterey",
                        state: "CA",
                        zip: 35872)

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_content(shelter_1.name)
      click_on 'Delete Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end
