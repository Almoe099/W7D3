class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:destroy]


  def create

    email = params[:user][:email]
    password = params[:user][:password]

    @user = User.find_by_credentials(email, password)

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(email: email)
      flash.now[:errors] = ["Invaild Credentials"]
      render :new
    end

  end

  def new
    @user = User.new
    render :new
  end

  def :destroy
    logout!
    flash[:message] = ["Successfully Logout"]
    redirect_to new_session_url
  end

end
