
  
class UsersController < ApplicationController
  before_action :authorize_request, except: [:create, :login]
  skip_before_action :verify_authenticity_token, only: [:create, :login]

  def show
    user = User.find_by(id: @current_user.id)
    render json: user
  end

  def create
    user = User.find_or_initialize_by(email: user_params[:email])
  
    if user.persisted?
      render json: { errors: ['User already exists'] }, status: :unprocessable_entity
    else
      user.assign_attributes(user_params)
      user.role = params[:role] || (user.email == 'admin@example.com' ? 'admin' : 'user')
  
      if user.save
        token = JWT.encode({ user_id: user.id, role: user.role }, 'secret')
        render json: { user: user, token: token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  

  def reset_password
          user = User.find_by(email: params[:email])
          if user
            user.generate_reset_password_token
            user.save
            render json: { message: 'Reset password token generated', reset_password_token: user.reset_password_token }
          else
            render json: { error: 'User not found' }, status: :not_found
          end
        end
      
        def update_password
          user = User.find_by(reset_password_token: params[:reset_password_token])
          if user && user.reset_password_token_valid?
            user.update(password: params[:password], reset_password_token: nil, reset_password_token_expires_at: nil)
            render json: { message: 'Password updated successfully' }
          else
            render json: { error: 'Invalid or expired reset password token' }, status: :unprocessable_entity
          end
        end
      
  
        def login
          user = User.find_by(email: params[:email])
        
          if user&.authenticate(params[:password])
            token = JWT.encode({ user_id: user.id, role: user.email == 'admin@example.com' ? 'admin' : 'user' }, 'secret')
            @current_user = user # Set @current_user
        
            if user.email == 'admin@example.com'
              render json: { user: user, token: token, isAdmin: true, redirect_to: '/admin' }
            else
              render json: { user: user, token: token, isAdmin: false, redirect_to: '/', role: 'user' }
            end
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end
        
  

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
  
    begin
      decoded = JWT.decode(token, 'secret', true, algorithm: 'HS256')
      user_id = decoded.first['user_id']
      @current_user = User.find(user_id)
    rescue JWT::DecodeError, JWT::ExpiredSignature
      render json: { error: 'Invalid or expired token' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password, :username, :role, :password_confirmation)
  end
end
