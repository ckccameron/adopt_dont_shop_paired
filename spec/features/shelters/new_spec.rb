require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click on the New Shelter link on the index page' do
    describe 'I fill out a form on /shelters/new' do
      it 'then a new shelter is created' do

      visit '/shelters'

      click_on 'New Shelter'
      expect(current_path).to eq('/shelters/new')

      name = "Denver Animal Shelter"
      address = "3301 Navajo Street"
      city = 'Denver'
      state = 'CO'
      zip = 80211

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button "Create Shelter"

      expect(current_path).to eq('/shelters')
      expect(page).to have_content(name)
      expect(page).to_not have_content(address)
      end
    end


      it 'if one or more fields are not filled out, then a flash message will notify me about which fields need to be filled out' do

      visit '/shelters'

      click_on 'New Shelter'
      expect(current_path).to eq('/shelters/new')

      name = "Denver Animal Shelter"
      address = "3301 Navajo Street"
      city = 'Denver'
      state = 'CO'
      zip = 80211

      # fill_in :name, with: name
      # fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button "Create Shelter"

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Address can't be blank")
    end
  end
end
