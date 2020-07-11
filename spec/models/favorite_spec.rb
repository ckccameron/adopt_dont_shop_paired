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
end
