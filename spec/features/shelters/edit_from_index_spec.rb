require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click the EDIT button by a shelter on the index page' do
    describe 'I am redirected to a form' do
    it 'then I can edit the details of the shelter' do

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

      visit "/shelters/"
      expect(page).to have_content("Aurora Animal Shelter")

      click_on 'Edit Aurora Animal Shelter'

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
      expect(page).to_not have_content("Aurora Animal Shelter")
      expect(page).to_not have_content("3301 Navajo Street")
      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(zip)
    end
  end

  it 'If one or more fields are missing, the attempt to update the shelter information will return a flash message indicating which fields are missing' do

    shelter_1 =  Shelter.create!(name: "Aurora Animal Shelter",
                      address: "3301 Navajo Street",
                      city: "Denver",
                      state: "CO",
                      zip: 80021)

    visit "/shelters/"
    expect(page).to have_content("#{shelter_1.name}")

    click_on "Edit #{shelter_1.name}"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    city = 'Denver'
    state = 'CO'
    zip = 80206

    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_on 'Update Shelter'

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
  end
end
