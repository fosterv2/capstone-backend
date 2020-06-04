class CommentsController < ApplicationController
    def index
        comments = Comment.where("post_id = ?", params[:post_id])
        render json: comments.to_json(except: [:updated_at, :post_id])
    end

    def create
        comment = Comment.create(set_params)
        render json: comment.to_json(except: [:updated_at])
    end

    def update
        comment = Comment.find(params[:id])
        comment.update(set_params)
        render json: comment.to_json(except: [:updated_at])
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
    end

    private

    def set_params
        params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
