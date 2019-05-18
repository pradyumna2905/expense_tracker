require 'rails_helper'
describe 'User navigates to a non-existing page' do
  before do
    # Temporarily keeping this here
    Rails.application.configure do
      config.consider_all_requests_local = false
      config.action_dispatch.show_exceptions = true
    end
  end

  it 'displays the custom 404 message' do
    visit '/not_found'

    expect(page).to have_content("(404)")
    expect(page).
      to have_content(
        "Oops! Looks like you landed in a place which does not exist!"
    )
  end
end
