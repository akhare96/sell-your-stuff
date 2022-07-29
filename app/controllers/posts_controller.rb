class PostsController < ApplicationController
    before_action :verify_logged_in, only: [:new, :create, :edit, :update]
    before_action :verify_user_owns_post, only: [:edit, :update]

    def index
        @user = current_user
        @categories = Category.all
        
        if params[:user_id] #if statement for nested resource - all posts from a specific user
            @user = User.find_by(id: params[:user_id])
            if @user.nil?
                flash[:alert] =  "user not found"
                redirect_to posts_path
            else
                @posts = @user.posts
            end
        elsif !params[:categories].blank? #if statements for filtering posts
            @posts = Post.categories_filter(@user, params[:categories])
        elsif !params[:price].blank?
            if params[:price] == "Low to High"
              @posts = Post.low_to_high(@user)
            else
              @posts = Post.high_to_low(@user)
            end
        elsif logged_in? && !@user.location.nil? #when user logs in, @posts will be all posts from location if set
            @posts = Post.user_with_location(@user)
        else
            @posts = Post.all
        end
    end
    
    def new
        @post = Post.new(user_id: params[:user_id])
        #another way: @post.build_location(city: "", state: "")
    end

    def show
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            @post = Post.find_by(id: params[:id])
            if @post.nil? #if statement for when user enters non-existing user or post id in URL
                flash[:alert] =  "post not found"
                redirect_to posts_path
            elsif @user.nil?
                flash[:alert] =  "User not found"
                redirect_to posts_path
            elsif !@user.posts.include?(@post)
                flash[:alert] = "Post does not belong to user"
                redirect_to posts_path
            end
        else
            @post = Post.find(params[:id])
        end
        @favorite = current_user.favorites.find_by(post: @post) if logged_in? #see if @post belongs to user to determine whether to display 'favorite' or 'unfavorite'
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            flash[:notice] = "Successfully created post"
            redirect_to post_path(@post)
        else
            flash.now[:alert] = "Post not saved"
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.delete
        redirect_to posts_path
    end

    def purge_image
        image = ActiveStorage::Attachment.find(params[:id])
        image.purge
        flash[:notice] = "Deleted Image"
        redirect_back fallback_location: root_path
    end

    private

    def verify_user_owns_post
        redirect_to posts_path unless current_user.posts.include?(Post.find(params[:id]))
    end

    def post_params
        params.require(:post).permit(:user_id, :name, :price, :description, :make_manufacturer, :model_number, :size_dimensions, :condition, :quantity, :show_phone, :phone_calls, :phone_texts, :show_email, location_attributes: [:state, :city], category_ids:[], images: [])
    end
end