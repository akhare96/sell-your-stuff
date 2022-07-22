class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :logged_in?
    helper_method :current_user
    helper_method :date_created

    def homepage
        redirect_to posts_path if logged_in?
    end

    private

    def set_session(user)
        session[:user_id] = user.id
    end

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def verify_logged_in
        redirect_to root_path unless logged_in?
    end

    def location_attributes=(location)
        self.location = Location.find_or_create_by(state: location[:state], city: location[:city])
        self.location.update(location)
    end

    def date_created(post)
        post.created_at.strftime("%b %e, %Y")
    end

end
