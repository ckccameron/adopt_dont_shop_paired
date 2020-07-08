require 'rails_helper'

RSpec.describe "when visiting a shelter's show page" do
  it "allows user to edit a shelter review" do
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

    click_on "Edit Review"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

    fill_in :title, with: "Syke - This shelter is beat!"
    fill_in :rating, with: 1
    fill_in :content, with: "These poor animals. Wish I could adopt them all!"

    click_on "Update Review"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Syke - This shelter is beat!")
    expect(page).to have_content(1)
    expect(page).to have_content("These poor animals. Wish I could adopt them all!")
  end

  it "shows flash message if user fails to enter a title, rating, or content in edit form" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                              address: "3301 Navajo Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80021)

    review_1 = shelter_1.reviews.create(title: "Great Shelter",
                                        rating: 4,
                                        content: "All the pets looked really happy")

    visit "shelters/#{shelter_1.id}"

    click_on "Edit Review"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

    fill_in :title, with: ""

    click_on "Update Review"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
    expect(page).to have_content("Make sure you filled out the title, rating and content sections. Images are optional.")
  end
end
