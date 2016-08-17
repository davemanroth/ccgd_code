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
end
