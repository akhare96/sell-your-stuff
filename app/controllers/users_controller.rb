class UsersController < ApplicationController
    
    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if user.save
            session[:user_id] = @user.id
            flash[:valid_new] = "Account successfully created"
            #redirect_to posts_path
        else
            flash[:invalid_new] = "Failed to create a new account"
            #redirect_to new_user_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation)
    end

end