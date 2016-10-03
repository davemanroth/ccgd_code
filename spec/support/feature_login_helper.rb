module FeatureLoginHelper
  def login(user)
    user.status = 'A'
    user.save
    visit root_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def logout(user)
    visit root_url
    within '#main-nav' do
      click_link 'Log out'
    end
  end
end

