class UsersController < ApplicationController
    before_action :verify_logged_in, only: [:edit, :update]
    before_action :verify_user_can_edit, only: [:edit, :update]
    
    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            set_session(@user)
            flash[:valid_new] = "Account successfully created"
            redirect_to posts_path
        else
            flash.now[:invalid_new] = "Failed to create a new account"
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        if current_user.update(user_params)
            redirect_to posts_path
        else
            render :edit
        end
    end
    

    private

    def verify_user_can_edit
        redirect_to posts_path unless current_user.id == User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation)
    end

end