require 'rails_helper'

describe 'User signs up' do
  before do
    visit root_path
  end

  context 'with valid credentials' do
    it 'signs up user successfully' do
      expect(page).to have_content("Sign up")

      fill_in_this_with_that("Email", "john@example.com")
      find_and_fill_in('input[name="user[password]"]', "secret_password")
      find_and_fill_in('input[name="user[password_confirmation]"]',
                       "secret_password")

      submit_form

      expect(page).to have_content("New Expense")
    end
  end

  context 'with invalid credentials' do
    before do
      fill_in_this_with_that("Email", "john")
      find_and_fill_in('input[name="user[password]"]', "secret_password")
      find_and_fill_in('input[name="user[password_confirmation]"]',
                       "secret")

      submit_form
    end

    it 'does not sign up user successfully' do
      expect(page).to have_content("Sign up")
    end

    it 'shows validation errors' do
      expect(page).to have_content("Please review the problems below:")
      expect(page).to have_content("is invalid")
      expect(page).to have_content("doesn\'t match Password")
    end
  end
end
