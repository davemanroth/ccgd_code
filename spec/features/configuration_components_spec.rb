require 'rails_helper'

feature "ConfigurationComponents", :type => :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login(admin)
  end

  feature "Addresses CRUD" do
    let(:addr) { build(:address) }

    scenario "Creating a new address" do
      visit new_address_path

      expect(page).to have_content("Create new address")

      expect {
        fill_in "Street", with: addr.street
        fill_in "City", with: addr.city
        fill_in "Country", with: addr.country
        select "MA", from: "address_state"
        click_on "Create new address"
      }.to change(Address, :count).by(+1)
    end

    scenario "Updating an address" do
      addr.save
      visit edit_address_path(addr)

      expect(page).to have_content("Update an address")

      within ".col-md-6" do
        expect(page.find('#address_street').value).to eq(addr.street)
        fill_in "Street", with: "New street address"
      end
      click_on "Update address"

      expect(page).to have_content("Address successfully updated")
      addr.reload
      expect(addr.street).to eq("New street address")
    end

  end

  feature "Location CRUD" do
    let(:loc) { build(:location) }

    scenario "Creating a new location" do
      visit new_location_path

      expect(page).to have_content("Create a new location")

      expect {
        fill_in "Building", with: loc.building
        fill_in "Room", with: loc.room
        select "44 Binney Street, Boston, MA", from: "location_address_id"
        click_on "Create new location"
      }.to change(Location, :count).by(+1)
    end

    scenario "Updating a location" do
      loc.save
      visit edit_location_path(loc)

      expect(page).to have_content("Update a location")

      within ".col-md-6" do
        expect(page.find('#location_building').value).to eq(loc.building)
        fill_in "Building", with: "New location building"
      end
      click_on "Update location"

      expect(page).to have_content("Location successfully updated")
      loc.reload
      expect(loc.building).to eq("New location building")
    end

  end

  feature "Platform CRUD" do
    let(:plat) { build(:platform) }

    scenario "Creating a new platform" do
      visit new_platform_path

      expect(page).to have_content("Create a new platform")

      expect {
        fill_in "Name", with: plat.name
        fill_in "Code", with: plat.code
        click_on "Create new platform"
      }.to change(Platform, :count).by(+1)
    end

    scenario "Updating a platform" do
      plat.save
      visit edit_platform_path(plat)

      expect(page).to have_content("Update a platform")

      within ".col-md-6" do
        expect(page.find('#platform_name').value).to eq(plat.name)
        fill_in "Name", with: "New platform name"
      end
      click_on "Update platform"

      expect(page).to have_content("Platform successfully updated")
      plat.reload
      expect(plat.name).to eq("New platform name")
    end

  end
=begin
=end
end
