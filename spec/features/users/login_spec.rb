require 'rails_helper'

describe 'User logs in' do
  let(:user) { create(:user) }

  before do
    visit root_path
    click_link "Log in"
  end

  context 'with valid credentials' do
    it 'logs in user successfully' do
      fill_in_this_with_that("Email", user.email)
      fill_in_this_with_that("Password", user.password)

      submit_form

      expect(page).to have_content("CURRENT")
      expect(page).to have_content("TRENDS")
    end
  end

  context 'with invalid credentials' do
    before do
      fill_in_this_with_that("Email", "john@example.com")
      fill_in_this_with_that("Password", "wrong_password")

      submit_form
    end

    it 'does not log in user' do
      expect(page).to have_content("Log in")
    end

    it 'shows and error' do
      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
