class GroupsController < ApplicationController
    def index
        groups = Group.all
        render json: groups.to_json(except: [:created_at, :updated_at])
    end

    def create
        group = Group.create(set_params)
        render json: group.to_json(except: [:created_at, :updated_at])
    end

    private
    
    def set_params
        params.require(:group).permit(:name, :description)
    end
end
