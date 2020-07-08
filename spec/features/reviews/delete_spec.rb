require 'rails_helper'

RSpec.describe "delete a review" do
  it "allows user to delete a review" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                              address: "3301 Navajo Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80021)

    review_1 = shelter_1.reviews.create(title: "Great Shelter",
                                        rating: 4,
                                        content: "All the pets looked really happy")

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(review_1.title)

    click_on "Delete Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).not_to have_content(review_1.title)
    expect(page).not_to have_content(review_1.rating)
    expect(page).not_to have_content(review_1.content)
  end
end
