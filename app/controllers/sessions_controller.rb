class SessionsController < ApplicationController

  before_action :already_signed_in, except: :destroy

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in(user)
      flash[:success] = "Signed in!"
      redirect_to home_path
    else
      flash[:alert] = "Email or password is invalid!"
      redirect_to sign_in_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed out!"
    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

end