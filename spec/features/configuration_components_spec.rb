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

  feature "Organization CRUD" do
    let(:org) { build(:organization) }

    scenario "Creating a new organization" do
      visit new_organization_path

      expect(page).to have_content("Create a new organization")

      expect {
        fill_in "Name", with: org.name
        fill_in "Phone", with: org.phone
        fill_in "Email", with: org.email
        select "44 Binney Street, Boston, MA", from: "organization_address_id"
        click_on "Create new organization"
      }.to change(Organization, :count).by(+1)
    end

    scenario "Updating an organization" do
      org.save
      visit edit_organization_path(org)

      expect(page).to have_content("Update an organization")

      within ".col-md-6" do
        expect(page.find('#organization_name').value).to eq(org.name)
        fill_in "Name", with: "New organization name"
      end
      click_on "Update organization"

      expect(page).to have_content("Organization successfully updated")
      org.reload
      expect(org.name).to eq("New organization name")
    end

  end

  feature "Labgroup CRUD" do
    let(:lg) { build(:lab_group) }

    scenario "Creating a new labgroup" do
      visit new_lab_group_path

      expect(page).to have_content("Create a new labgroup")

      expect {
        fill_in "Name", with: lg.name
        fill_in "Code", with: lg.code
        select "Dana, 1539", from: "lab_group_location_id"
        click_on "Create new labgroup"
      }.to change(LabGroup, :count).by(+1)
    end

    scenario "Updating an organization" do
      lg.save
      visit edit_lab_group_path(lg)

      expect(page).to have_content("Update a labgroup")

      within ".col-md-6" do
        expect(page.find('#lab_group_name').value).to eq(lg.name)
        fill_in "Name", with: "New labgroup name"
      end
      click_on "Update labgroup"

      expect(page).to have_content("Labgroup successfully updated")
      lg.reload
      expect(lg.name).to eq("New labgroup name")
    end

  end

  feature "Sample type CRUD" do
    let(:st) { build(:sample_type) }

    scenario "Creating a new sample type" do
      visit new_sample_type_path

      expect(page).to have_content("Create a new sample type")

      expect {
        fill_in "Name", with: st.name
        click_on "Create new sample type"
      }.to change(SampleType, :count).by(+1)
    end

    scenario "Updating a sample type" do
      st.save
      visit edit_sample_type_path(st)

      expect(page).to have_content("Update a sample type")

      within ".col-md-6" do
        expect(page.find('#sample_type_name').value).to eq(st.name)
        fill_in "Name", with: "New sample type name"
      end
      click_on "Update sample type"

      expect(page).to have_content("Sample type successfully updated")
      st.reload
      expect(st.name).to eq("New sample type name")
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
