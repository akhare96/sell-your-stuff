class SessionsController < ApplicationController

  def new
    redirect_to posts_path if logged_in?
  end

  def create
    #user logs in -> redireted to /auth/twitter2 -> redirect to twitter sign in -> authorize -> redirect to /auth/twitter2/callback -> target webpage
    if !auth.nil?
      twitter_nickname = auth['info']['nickname']
      twitter_email = auth['info']['email']
      @user = User.find_or_create_by(username: twitter_nickname) do |u|
        #edge case: user signs up with github where email is private (value = nil).  Sets up email within app but next time sign in then email gets set to nil again.
        u.email = twitter_email
        u.password = SecureRandom.hex
      end
      set_session(@user)
      flash[:notice] = "Successfully logged in"
      redirect_to posts_path
    else 
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password]) #user.try(:authenticate, params[:password]) - object.try(:some_method) = if object != nil then object.some_method else nil end
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