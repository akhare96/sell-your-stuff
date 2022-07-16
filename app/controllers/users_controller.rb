class UsersController < ApplicationController
    before_action :verify_logged_in, only: [:edit, :update]
    
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
        if verify_correct_user
            @user = User.find(params[:id])
        else
            redirect_to posts_path
        end
    end

    def update
        if verify_correct_user
            if current_user.update(user_params)
                redirect_to posts_path
            else
                render :edit
            end
        else
            redirect_to posts_path
        end
    end
    

    private

    def verify_correct_user
        current_user.id == User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation)
    end

end