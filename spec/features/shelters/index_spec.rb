require 'rails_helper'

RSpec.describe 'Shelters Index Page' do
  describe 'as a visitor' do
    it 'index page shows a list of each shelter name in the system' do

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
      visit '/shelters'

      expect(page).to have_content(shelter_1.name)
      expect(page).to_not have_content(shelter_1.address)
      expect(page).to have_content(shelter_2.name)
    end
  end
end
