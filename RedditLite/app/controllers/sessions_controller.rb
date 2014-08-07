class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(
                user_params[:username],
                user_params[:password])
    if user
      sign_in(user)
      redirect_to posts_url
    else
      flash.now[:errors] = ["Invalid Username/Password Combination."]
      render :new
    end
  end

  def new
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end


end
