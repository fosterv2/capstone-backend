class GroupsController < ApplicationController
    def index
        groups = Group.all
        render json: groups.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    # def index_by_user
    #     groups = Group.all.filter{ |group| group.user_ids.include?(params[:user_id]) }
    #     render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    # end

    def show
        group = Group.find(params[:id])
        render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    def create
        group = Group.create(set_params)
        # maybe make the creator an attribute, and creator can update
        User.find(params[:user_id]).groups << group
        render json: group.to_json(include: [:users], except: [:created_at, :updated_at])
    end

    private
    
    def set_params
        params.require(:group).permit(:name, :description)
    end
end
