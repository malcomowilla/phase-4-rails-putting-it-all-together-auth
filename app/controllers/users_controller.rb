class UsersController < ApplicationController
    before_action :authorize
    def create_users
        user = User.create(user_params)
        
        if user.valid?
      session[:user_id] = user.id
       render json: user, status: :created

        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id:session[:user_id])
        if user
            render json: user, status: :created
        else
            render json: {error: 'Not authorized'}, status: :unauthorized
        end
    end

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
            
        else
            render json: {error: 'Invalid username or password'}, status: :unauthorized
        end
    end
    
    def destroy
        session.delete :user_id
        head :no_content
    end
private


    def user_params
        params.permit(:username, :password, :image_url)
    end
end
