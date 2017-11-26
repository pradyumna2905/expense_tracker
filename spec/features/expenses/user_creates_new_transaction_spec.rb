require 'rails_helper'

describe 'User creates new transaction' do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit new_transaction_path
  end

  context 'with valid data' do
    it 'saves the transaction successfully' do
      expect(page).to have_content("New Transaction")

      select_this_from_that("2017", "transaction_date_1i")
      select_this_from_that("May", "transaction_date_2i")
      select_this_from_that("29", "transaction_date_3i")
      fill_in_this_with_that("Description", "Beer")
      fill_in_this_with_that("Amount", 10)

      expect(page).to have_select("transaction_category_id", options: ["Uncategorized"])
      expect(page).to have_select("transaction_payment_method_id", options: ["Cash"])
      submit_form
      click_link "MAY"

      expect(page).to have_content("$10.00")
      expect(page).to have_content("Beer")
      expect(page).to have_content("May 29, 2017")
      expect(page).to have_content("Cash")
      expect(page).to have_content("Uncategorized")
    end
  end

  context 'with invalid data' do
    it 'does not save the transaction successfully' do
      expect(page).to have_content("New Transaction")

      select_this_from_that("2020", "transaction_date_1i")
      select_this_from_that("May", "transaction_date_2i")
      select_this_from_that("29", "transaction_date_3i")
      fill_in_this_with_that("Description", "")
      fill_in_this_with_that("Amount", nil)
      expect(page).to have_select("transaction_category_id", options: ["Uncategorized"])
      expect(page).to have_select("transaction_payment_method_id", options: ["Cash"])

      submit_form

      expect(page).to have_content("New Transaction")
      expect(page).to have_content("can\'t be in the future.")
      expect(page).to have_content("can\'t be blank")
    end
  end
end
