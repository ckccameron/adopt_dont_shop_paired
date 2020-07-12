require 'rails_helper'

RSpec.describe Favorite do
  describe "#total count" do
    it "calculates total count of favorites" do
      favorite = Favorite.new({'1' => 1, '2' => 1})

      expect(favorite.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "can add pet to favorites" do
      favorite = Favorite.new({'1' => 0, '2' => 0})

      favorite.add_pet(1)
      favorite.add_pet(2)

      expect(favorite.contents).to eq({'1' => 1, '2' => 1})
    end
  end

  describe "#count_of" do
    it "can count number of all pets in favorites" do
      favorite = Favorite.new({})

      expect(favorite.count_of(3)).to eq(0)
    end
  end

  describe "#favorite_pets" do
    it "provides id of a favorite pet" do
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

      favorite = Favorite.new(pet_1.id => 1)

      expect(favorite.favorite_pets).to eq([pet_1])
    end
  end

  describe "#favorite_already?" do
    it "checks if pet was added to favorites already" do
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

      favorite = Favorite.new(pet_1.id => 1)

      favorite.add_pet(pet_1)

      expect(favorite.favorite_already?(pet_1.id)).to eq(1)
      expect(favorite.favorite_already?(pet_1.id)).to_not eq(2)
    end
  end

  describe "#remove_pet" do
    it "takes pet out of favorites" do
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

      favorite = Favorite.new(pet_1.id => 1)

      favorite.remove_pet(pet_1)

      expect(favorite.count_of(pet_1.id)).to eq(0)
    end
  end
end
