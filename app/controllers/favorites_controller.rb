class FavoritesController < ApplicationController
    before_action :verify_logged_in
    before_action :user_owns_favorites, only: [:index]

    def index
        @favorites = User.find(params[:user_id]).favorites
    end

    def create
        @favorite = current_user.favorites.create(favorite_params)
        redirect_back fallback_location: root_path
    end

    def destroy
        @favorite = current_user.favorites.find(params[:id])
        @favorite.destroy
        redirect_back fallback_location: root_path
    end


    private

    def user_owns_favorites
        redirect_to posts_path unless current_user == User.find(params[:user_id])
    end

end