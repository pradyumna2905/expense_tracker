class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :require_user

  def require_user
    unless user_signed_in?
      flash[:danger] = "You need to be logged in to view your expenses!"
      redirect_to new_user_session_path
    end
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource)
    new_expense_path
  end
end
