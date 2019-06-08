require 'spec_helper'
require 'rails_helper'


feature 'Sign Up' do
  before(:each) do
    visit new_user_url
  end

  feature 'the signup process' do
    scenario 'has a new user page' do
      expect(page).to have_content('Sign Up')
    end
  end

  feature 'signing up a user' do
    scenario 'takes username and password' do
      expect(page).to have_content("Username")
      expect(page).to have_content("Password")
    end
  end

  scenario 'probably creates a new user and redirects to show page' do
    fill_in "Username", with: "champagnepapi"
    fill_in "Password", with: "password123"

    click_button "Sign Up"

    expect(page).to have_content("champagnepapi")
    papi = User.last
    expect(current_path).to eq(user_path(papi))

  end

end

feature 'Sign In' do
  before(:each) do
    User.create(username: "champagnepapi", password: "password123")
    visit new_session_url
  end

  feature 'sign in process' do
    scenario 'has a sign in page' do
      expect(page).to have_content("Sign In")
    end
  end

  feature 'signing in a user' do
    scenario 'takes username and password' do
      expect(page).to have_content("Username")
      expect(page).to have_content("Password")
    end
  end

  scenario 'probably creates a new user and redirects to show page' do
    fill_in "Username", with: "champagnepapi"
    fill_in "Password", with: "password123"

    click_button "Sign In"

    expect(page).to have_content("champagnepapi")
    papi = User.last
    expect(current_path).to eq(user_path(papi))
  end
  
end





