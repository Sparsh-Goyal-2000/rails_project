require "application_system_test_case"

class CatagoriesTest < ApplicationSystemTestCase
  setup do
    @catagory = catagories(:one)
  end

  test "visiting the index" do
    visit catagories_url
    assert_selector "h1", text: "Catagories"
  end

  test "creating a Catagory" do
    visit catagories_url
    click_on "New Catagory"

    fill_in "Title", with: @catagory.title
    click_on "Create Catagory"

    assert_text "Catagory was successfully created"
    click_on "Back"
  end

  test "updating a Catagory" do
    visit catagories_url
    click_on "Edit", match: :first

    fill_in "Title", with: @catagory.title
    click_on "Update Catagory"

    assert_text "Catagory was successfully updated"
    click_on "Back"
  end

  test "destroying a Catagory" do
    visit catagories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Catagory was successfully destroyed"
  end
end
