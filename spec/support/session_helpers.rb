module SessionHelpers
  include FormHelpers
  def sign_in(user)
    visit root_path
    click_link "Log in"

    fill_in_this_with_that("Email", user.email)
    fill_in_this_with_that("Password", user.password)

    submit_form
  end
end
