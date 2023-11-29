class SessionsController < ApplicationController

  def create

    email = params[:users][:email]
    password = params[:users][:password]

    @user = User.find_by_credentials(email, password)

    if @user
      login(@user)
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
