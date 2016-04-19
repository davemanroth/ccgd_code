module FeatureLoginHelper
  def login(user)
    visit root_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def logout(user)
    visit root_url
    click_link 'Log out'
  end
end

