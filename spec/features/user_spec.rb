require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
  scenario 'user page is rendered successfully' do
    visit '/sign_up'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    click_on 'Sign In'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    expect(page).to have_content(
      "Events Created:\nYou have registered for the following events:\n"\
      "You have registered for the following Upcoming events:\nYou have registered for "\
       'the following Previous events:'
    )
  end

  scenario 'clicking on user name leads to user page' do
    visit sign_up_path
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    click_on 'Sign In'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit events_path
    click_on 'Marylene'
    expect(page).to have_content(
      "Events Created:\nYou have registered for the following events:\n"\
      "You have registered for the following Upcoming events:\nYou have registered for "\
      'the following Previous events:'
    )
  end

  scenario '' do
  end

  scenario 'invalid inputs for creating an event - description omitted' do
    visit '/sign_up'
    click_on 'Submit'
    expect(page).to have_content('Name can\'t be blank')
  end

  scenario 'invalid inputs for creating a user - name too short' do
    visit '/sign_in'
    click_on 'Sign Up'
    fill_in 'user_name', with: 'M'
    click_on 'Submit'
    expect(page).to have_content('Name is too short (minimum is 2 characters)')
  end
end
