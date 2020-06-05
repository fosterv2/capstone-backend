class UsersController < ApplicationController
    def create
        user = User.new(set_params)
        user.password = params[:password]
        if user.save
            token = encode_token(user)
            render json: { user: UserSerializer.new(user), jwt: token }
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def update
        user = User.find(params[:id])
        if user.update(set_params)
            render json: user.to_json(except: [:created_at, :updated_at])
        else
            render json: {error: user.errors.full_messages}, status: 401
        end
    end

    # def destroy
    # end

    private

    def set_params
        params.require(:user).permit(:username, :owner_name, :breed, :img_url, :password, :password_confirmation)
    end
end
