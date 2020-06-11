class UsersController < ApplicationController
    def create
        user = User.new(set_params)
        user.password = params[:password]
        user.save
        if user.valid?
            token = encode_token({ user_id: user.id })
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

    def add_group
        group = Group.find(params[:group_id])
        UserGroup.create(user_id: params[:user_id], group_id: params[:group_id])
        render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    def remove_group
        group = Group.find(params[:group_id])
        UserGroup.where("group_id = ? AND user_id = ?", params[:group_id], params[:user_id])[0].destroy
        render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    # def destroy
    # end

    private

    def set_params
        params.require(:user).permit(:username, :owner_name, :breed, :img_url, :password, :password_confirmation)
    end
end
