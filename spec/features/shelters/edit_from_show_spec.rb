require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click the EDIT button by a shelter on the show page' do
    describe 'I am redirected to a form' do
    it 'then I can edit the details of the shelter' do

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
      expect(page).to have_content("Denver Animal Shelter")

      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      name = "LoHi Animal Shelter"
      address = "3501 Pecos Street"
      city = 'Denver'
      state = 'CO'
      zip = 80206
      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to_not have_content("Denver Animal Shelter") 
      expect(page).to_not have_content("3301 Navajo Street")
      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(zip)
    end
  end
end
end
