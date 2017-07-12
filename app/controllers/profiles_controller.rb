class ProfilesController < ApplicationController
  def show
    @payment_methods = current_user.payment_methods.
      reject(&:default_payment_method?)
    @categories = current_user.categories.
      reject(&:default_category?)
  end
end
