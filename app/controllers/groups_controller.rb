class GroupsController < ApplicationController
    def index
        groups = Group.all
        render json: groups.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    def create
        group = Group.create(set_params)
        User.find(params[:creator_id]).groups << group
        render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    def update
        group = Group.find(params[:id])
        group.update(set_params)
        render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    private
    
    def set_params
        params.require(:group).permit(:name, :description, :creator_id)
    end
end
