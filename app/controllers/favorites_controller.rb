class FavoritesController < ApplicationController
    before_action :verify_logged_in
    before_action :user_owns_favorites, only: [:index]



    private

    def user_owns_favorites
        redirect_to posts_path unless current_user == User.find(params[:user_id])
    end

end