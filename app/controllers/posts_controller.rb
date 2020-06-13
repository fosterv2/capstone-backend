class PostsController < ApplicationController
    def index
        posts = Post.all
        render json: posts.to_json(include: [:user], except: [:updated_at])
    end

    def index_by_group
        posts = Post.where("group_id = ?", params[:group_id])
        render json: posts.to_json(include: [:user], except: [:updated_at])
    end

    def show
        post = Post.find(params[:id])
        render json: post.to_json(include: [:user], except: [:updated_at])
    end

    def create
        post = Post.create(set_params)
        # post["deleted"] = false
        # post.save
        render json: post.to_json(include: [:user], except: [:updated_at])
    end

    def update
        post = Post.find(params[:id])
        post.update(set_params)
        render json: post.to_json(include: [:user], except: [:updated_at])
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
    end

    private

    def set_params
        params.require(:post).permit(:content, :user_id, :group_id, :post_img, :likes)
    end
end
