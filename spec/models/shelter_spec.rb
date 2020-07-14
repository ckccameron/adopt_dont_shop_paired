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

    it 'calculates .average_rating' do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)
      pet_1 =  Pet.create!(name: "Winnie",
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

      pet_3 =  Pet.create(name: "Benny",
                        approximate_age: 5,
                        sex: "Male",
                        image: "https://imgur.com/r/puppies/JGDU9mi",
                        adoption_status: "Available",
                        shelter_id: shelter_1.id)

      review_1 = Review.create!(title: "Great Shelter",
                        rating: 4,
                        content: "All the pets looked really happy",
                        shelter_id: shelter_1.id)
      review_1 = Review.create!(title: "Decent Shelter",
                        rating: 2,
                        content: "I've seen bigger",
                        shelter_id: shelter_1.id)

      application_1 = Application.create(name: "John",
                                        address: "1050 Blake St",
                                        city: "Denver",
                                        state: "CO",
                                        zip: "80205",
                                        phone_number: "3037179808",
                                        description: "I love animals")

      PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)

      application_2 = Application.create(name: "Jim",
                                        address: "4444 First St",
                                        city: "Evergreen",
                                        state: "CO",
                                        zip: "80587",
                                        phone_number: "7209487562",
                                        description: "Cute pup")

      PetApplication.create(pet_id: pet_3.id, application_id: application_2.id)

      expect(shelter_1.average_rating).to eq(3)
    end

    it 'calculates .total_applications' do

      shelter_1 =  Shelter.create!(name: "Denver Animal Shelter",
                        address: "3301 Navajo Street",
                        city: "Denver",
                        state: "CO",
                        zip: 80021)
      pet_1 =  Pet.create!(name: "Winnie",
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

      pet_3 =  Pet.create(name: "Benny",
                        approximate_age: 5,
                        sex: "Male",
                        image: "https://imgur.com/r/puppies/JGDU9mi",
                        adoption_status: "Available",
                        shelter_id: shelter_1.id)

      review_1 = Review.create!(title: "Great Shelter",
                        rating: 4,
                        content: "All the pets looked really happy",
                        shelter_id: shelter_1.id)
      review_1 = Review.create!(title: "Decent Shelter",
                        rating: 2,
                        content: "I've seen bigger",
                        shelter_id: shelter_1.id)

      application_1 = Application.create(name: "John",
                                        address: "1050 Blake St",
                                        city: "Denver",
                                        state: "CO",
                                        zip: "80205",
                                        phone_number: "3037179808",
                                        description: "I love animals")

      PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)

      application_2 = Application.create(name: "Jim",
                                        address: "4444 First St",
                                        city: "Evergreen",
                                        state: "CO",
                                        zip: "80587",
                                        phone_number: "7209487562",
                                        description: "Cute pup")

      PetApplication.create(pet_id: pet_3.id, application_id: application_2.id)

      expect(shelter_1.total_applications).to eq(2)
    end


  end
end
