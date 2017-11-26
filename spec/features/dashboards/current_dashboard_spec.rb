require 'rails_helper'

describe 'User visits current dashboard' do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  # TODO
  context 'when user has no transactions for the past week' do
    xit 'displays no-transactions message' do
      expect(page).to have_content "CURRENT"

      click_link "CURRENT"
      expect(page).to have_content "#{Date.current.strftime('%B %Y')} transactions"
      expect(page).
        to have_content "You do not have any transactions in the past week. Yay!"
    end
  end

  context 'when the user has transactions' do
    it 'displays the line chart and pie chart' do
      expect(page).to have_content "CURRENT"

      click_link "CURRENT"
      expect(page).to have_content "#{Date.current.strftime('%B %Y')} Transactions"

      # Chartkick squentially ids charts. So this is the line chart.
      expect(page).to have_css('div#chart-1')
      # And the pie charts
      expect(page).to have_css('div#chart-2')
      expect(page).to have_css('div#chart-3')
    end
  end
end
