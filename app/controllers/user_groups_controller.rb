class UserGroupsController < ApplicationController
    def create
        user_group = UserGroup.create(params.require(:user_group).permit(:user_id, :group_id))
    end
end
