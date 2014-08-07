class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def sign_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def sign_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def require_ownership!
    if Sub.find(params[:id]).moderator != current_user
      flash.now[:errors] = ["Must be moderator to perform that action"]
      redirect_to sub_url(params[:id])
    end
  end


  def require_signed_in!
    redirect_to new_session_url if !signed_in?
  end
end
