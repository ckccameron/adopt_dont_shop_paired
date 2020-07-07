#shelter links spec

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I click on the List of Shelters link' do
    it 'refreshes the shelter index page' do

      visit "/shelters"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from the pets index page to the shelters index page" do

      visit "/shelters"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from a shelter show page to the shelters index page" do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      visit "/shelters/#{shelter_1.id}"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from a shelter edit page to the shelters index page" do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      visit "/shelters/#{shelter_1.id}/edit"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from a shelter new page to the shelters index page" do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      visit "/shelters/new"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from a shelter pets index page to the shelters index page" do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      pet_1 =  Pet.create!(name: "Tom",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        description: "Simply the best",
                        shelter_id: shelter_1.id)

      visit "/shelters/#{shelter_1.id}/pets"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from a pet show page to the shelters index page" do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      pet_1 =  Pet.create!(name: "Tom",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        description: "Simply the best",
                        shelter_id: shelter_1.id)

      visit "/pets/#{pet_1.id}"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from a new pet page to the shelters index page" do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      pet_1 =  Pet.create!(name: "Tom",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        description: "Simply the best",
                        shelter_id: shelter_1.id)

      visit "/shelters/#{shelter_1.id}/pets/new"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "takes me from a edit pet page to the shelters index page" do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)

      pet_1 =  Pet.create!(name: "Tom",
                        approximate_age: 3,
                        sex: "Female",
                        image: "https://imgur.com/r/puppies/cYqJGNo",
                        adoption_status: "Available",
                        description: "Simply the best",
                        shelter_id: shelter_1.id)

      visit "/pets/#{pet_1.id}/edit"
      click_on "List of Shelters"
      expect(current_path).to eq("/shelters")
    end

  end
end
