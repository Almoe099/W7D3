class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

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

  def destroy
    logout!
    flash[:messages] = ["Successfully Logout"]
    redirect_to new_session_url
  end

end
