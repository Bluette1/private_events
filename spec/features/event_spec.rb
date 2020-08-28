require 'rails_helper'

RSpec.describe 'Event Features', type: :feature do
  scenario 'home page is rendered successfully' do
    visit '/sign_up'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    click_on 'Sign In'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    click_on 'Events'
    expect(page).to have_content(
      "Events\nDescription Date\nUpcoming Events\nDescription Date\nPast Events\nDescription Date"
    )
  end

  scenario 'a new event is created successfully' do
    visit '/sign_up'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit '/sign_in'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'

    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).to have_content('Event was successfully created.')
  end

  scenario 'invalid inputs for creating an event - duplicate descriptions' do
    visit '/sign_up'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit '/sign_in'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'

    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).not_to have_content('success')
    expect(page).to have_content('Description has already been taken')
  end

  scenario 'invalid inputs for creating an event - date omitted' do
    visit '/sign_up'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit '/sign_in'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'

    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    click_on 'Create Event'
    expect(page).not_to have_content('success')
    expect(page).to have_content('Date can\'t be blank')
  end

  scenario 'invalid inputs for creating an event - description omitted' do
    visit '/sign_up'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit '/sign_in'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'

    click_on 'New Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).not_to have_content('success')
    expect(page).to have_content('Description can\'t be blank')
  end

  scenario 'invalid inputs for creating an event - description too short' do
    visit '/sign_up'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'
    visit '/sign_in'
    fill_in 'user_name', with: 'Marylene'
    click_on 'Submit'

    click_on 'New Event'
    fill_in 'event_description', with: 'Ca'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).to have_content('Description is too short (minimum is 3 characters)')
  end
end
