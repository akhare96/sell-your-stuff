class UsersController < ApplicationController
    before_action :verify_logged_in, only: [:show, :edit, :update]
    before_action :verify_user_can_view, only: [:show, :edit, :update]
    
    def new
        redirect_to posts_path if logged_in?
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
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

    def verify_user_can_view
        redirect_to posts_path unless current_user == User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation, location_attributes: [:state, :city])
    end

end