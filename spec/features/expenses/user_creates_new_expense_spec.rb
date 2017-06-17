require 'rails_helper'

describe 'User creates new expense' do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  context 'with valid data' do
    it 'saves the expense successfully' do
      expect(page).to have_content("New Expense")

      select_this_from_that("2017", "expense_date_1i")
      select_this_from_that("May", "expense_date_2i")
      select_this_from_that("29", "expense_date_3i")
      fill_in_this_with_that("Description", "Beer")
      fill_in_this_with_that("Amount", 10)
      expect(page).to have_content("Add New Payment Method")

      submit_form

      expect(page).to have_content(user.grand_total)
      expect(page).to have_content("Beer")
      expect(page).to have_content("May 29, 2017")
      expect(page).to have_content("Cash")
    end
  end

  context 'with invalid data' do
    it 'does not save the expense successfully' do
      expect(page).to have_content("New Expense")

      select_this_from_that("2020", "expense_date_1i")
      select_this_from_that("May", "expense_date_2i")
      select_this_from_that("29", "expense_date_3i")
      fill_in_this_with_that("Description", "")
      fill_in_this_with_that("Amount", nil)
      expect(page).to have_content("Add New Payment Method")

      submit_form

      expect(page).to have_content("New Expense")
      expect(page).to have_content("can\'t be in the future.")
      expect(page).to have_content("can\'t be blank")
    end
  end
end
