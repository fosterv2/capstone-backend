class AuthController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            token = encode_token({ user_id: user.id })
            render json: { user: UserSerializer.new(user), jwt: token }
        else
            render json: {error: 'No user could be found'}, status: 401
        end
    end

    def show
        user = current_user
        if user && logged_in?
            render json: { user: UserSerializer.new(user) }
        else
            render json: {error: 'No user could be found'}, status: 401
        end
    end
end
