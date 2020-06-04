class UsersController < ApplicationController
    def create
        user = User.new(set_params)
        if user.save
            render json: user.to_json(except: [:created_at, :updated_at])
        else
            render json: {error: user.errors.full_messages}, status: 401
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
        params.require(:user).permit(:username, :name, :owner_name, :breed, :img_url, :password, :password_confirmation)
    end
end
