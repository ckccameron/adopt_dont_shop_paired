#shelters show spec 
require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I visit a shelter show page' do
    it 'that shows the shelter information' do

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

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.address)
      expect(page).to_not have_content(shelter_2.address)
      expect(page).to have_content(shelter_1.name)
      expect(page).to_not have_content(shelter_2.name)
    end
  end
end
