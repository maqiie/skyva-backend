
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authorize_request
    helper_method :current_user, :logged_in?
    
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def logged_in?
      !current_user.nil?
    end
  
    private
  
    def authorize_request
      if request.headers['Authorization'].present?
        authenticate_with_token
      else
        authenticate_with_session
      end
    end
  
    def authenticate_with_token
      token = extract_token_from_headers
  
      begin
        decoded = JWT.decode(token, 'secret', true, algorithm: 'HS256')
        user_id = decoded[0]['user_id']
        @current_user = User.find_by(id: user_id)
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  
    def authenticate_with_session
      unless logged_in?
        flash[:error] = 'Please log in'
        redirect_to login_path
      end
    end
  
    def extract_token_from_headers
      header = request.headers['Authorization']
      header.split(' ').last if header.present?
    end
  end
  