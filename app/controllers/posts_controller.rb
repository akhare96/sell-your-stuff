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

    def show
        @post = Post.find(params[:id])
    end

    def create
        @post = Post.new(post_params)
        params[:show_email] ? @post.show_email = true : @post.show_email = false
        params[:show_phone] ? @post.show_phone = true : @post.show_phone = false
        params[:phone_texts] ? @post.phone_texts = true : @post.phone_texts = false
        params[:phone_calls] ? @post.phone_calls = true : @post.phone_calls = false
        @post.user = current_user
        if @post.save
            flash[:valid_post] = "Successfully created post"
            redirect_to post_path(@post)
        else
            flash.now[:invalid_post] = "Post not saved"
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        params[:show_email] ? @post.show_email = true : @post.show_email = false
        params[:show_phone] ? @post.show_phone = true : @post.show_phone = false
        params[:phone_texts] ? @post.phone_texts = true : @post.phone_texts = false
        params[:phone_calls] ? @post.phone_calls = true : @post.phone_calls = false
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            render :edit
        end
    end

    def destroy
        @post.find(params[:id])
        @post.delete
        redirect_to posts_path
    end

    def purge_image
        image = ActiveStorage::Attachment.find(params[:id])
        image.purge
        redirect_back fallback_location: root_path, notice: "success"
    end

    private

    def verify_user_owns_post
        current_user.posts.include?(@post)
    end

    def post_params
        params.require(:post).permit(:name, :price, :description, :make_manufacturer, :model_number, :size_dimensions, :condition, :quantity, :show_phone, :phone_calls, :phone_texts, :show_email, location_attributes: [:state, :city], category_ids:[], images: [])
    end
end