require 'rails_helper'

RSpec.describe Shelter do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
  end

  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe 'methods' do
    it "calculates .total_pets" do
      shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                                  address: "3301 Navajo Street",
                                  city: "Denver",
                                  state: "CO",
                                  zip: 80021)

      pet_1 =  Pet.create(name: "Winnie",
                          approximate_age: 3,
                          sex: "Female",
                          image: "https://imgur.com/r/puppies/cYqJGNo",
                          adoption_status: "Available",
                          shelter_id: shelter_1.id)

      pet_2 =  Pet.create(name: "Sir Maximus",
                          approximate_age: 1,
                          sex: "Male",
                          image: "https://imgur.com/r/puppies/JGDU9mi",
                          adoption_status: "Available",
                          shelter_id: shelter_1.id)

      expect(shelter_1.total_pets).to eq(2)
    end
  end
end
