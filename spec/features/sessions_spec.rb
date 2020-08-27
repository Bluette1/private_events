require 'rails_helper'

RSpec.describe 'Sessions Features', type: :feature do
  scenario 'valid inputs' do
    visit '/sign_up'
    expect(page).to have_content('Sign Up')
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit '/sign_in'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    expect(page).to have_content('Logged_in user: Marylene')
  end

  scenario 'unregistered name for sign in' do
    visit sign_in_path
    fill_in 'user_name', with: 'Unknown'
    click_on 'Submit'
    expect(page).to have_content('Wrong name. Sign up or enter the correct name')
  end

  scenario 'Name too short for sign up' do
    visit sign_up_path
    fill_in 'user_name', with: 'A'
    click_on 'Submit'
    expect(page).to have_content('Name is too short (minimum is 2 characters)')
  end

  scenario 'Name not Unique Invalid Sign Up' do
    visit '/sign_up'
    expect(page).to have_content('Sign Up')
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit '/sign_up'
    expect(page).to have_content('Sign Up')
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    expect(page).to have_content('Name has already been taken')
  end
end
