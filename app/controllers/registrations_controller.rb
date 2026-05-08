class RegistrationsController < ApplicationController
  # This allows someone to visit the signup page even if they aren't logged in
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @user.role = :customer # Default everyone who signs up to a Customer

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome to ValleyHomeLink! Your account was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end
end