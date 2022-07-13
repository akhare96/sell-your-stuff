class SessionsController < ApplicationController

  def create
    if !auth.empty?
      github_username = auth['info']['nickname']
      github_email = auth['info']['email']
      @user = User.find_or_create_by(username: github_username) do |u|
        #edge case: user signs up with github where email is private (value = nil).  Sets up email within app but next time sign in then email gets set to nil again.
        u.email = github_email
        u.password = SecureRandom.hex
      end
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in"
      #redirect_to posts_path
    else 
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in"
        #redirect to posts_path
      else
        flash[:failure] = "failed to log in"
      end
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end