class PostsController < ApplicationController
    before_action :verify_logged_in, only: [:new, :create, :edit, :update]
    before_action :verify_user_owns_post, only: [:edit, :update]

    def index
        @post = Post.all
    end
    
    def new
        @post = Post.new
        #another way: @post.build_location(city: "", state: "")
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            flash[:valid_post] = "Successfully created post"
            redirect_to post_path(@post)
        else
            flash.now[:invalid_post] = "Post not saved"
            render :new
        end
    end


    private

    def verify_user_owns_post
        current_user.posts.include?(@post)
    end

    def post_params
        params.require(:post).permit(:name, :price, :description, :make_manufacturer, :model_number, :size_dimensions, :condition, :quantity, :show_phone, :phone_calls, :phone_texts, :show_email, location_attributes: [:state, :city], category_ids:[])
    end
end