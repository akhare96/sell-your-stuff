class SessionsController < ApplicationController

  def new
    redirect_to posts_path if logged_in?
  end

  def create
    if !auth.nil?
      github_username = auth['info']['nickname']
      github_email = auth['info']['email']
      @user = User.find_or_create_by(username: github_username) do |u|
        #edge case: user signs up with github where email is private (value = nil).  Sets up email within app but next time sign in then email gets set to nil again.
        u.email = github_email
        u.password = SecureRandom.hex
      end
      set_session(@user)
      flash[:notice] = "Successfully logged in"
      redirect_to posts_path
    else 
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        set_session(@user)
        flash[:notice] = "Successfully logged in"
        redirect_to posts_path
      else
        flash[:alert] = "Failed to log in. Please check your credentials."
        redirect_to login_path
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end