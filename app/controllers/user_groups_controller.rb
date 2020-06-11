class UserGroupsController < ApplicationController
    def create
        group = Group.find(params[:group_id])
        UserGroup.create(params.require(:user_group).permit(:user_id, :group_id))
        render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    end
end
