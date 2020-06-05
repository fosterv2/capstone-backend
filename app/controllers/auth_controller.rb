class AuthController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        # byebug
        if user && user.authenticate(params[:password])
            token = encode_token(user)
            render json: { user: UserSerializer.new(user), jwt: token }
        else
            render json: {error: 'No user could be found'}, status: 401
        end
    end

    def show
        user = User.find(params[:id])
        if user && logged_in?
            render json: user.to_json(except: [:created_at, :updated_at])
        else
            render json: {error: 'No user could be found'}, status: 401
        end
    end
end
