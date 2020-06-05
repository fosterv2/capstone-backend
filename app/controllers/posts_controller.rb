class PostsController < ApplicationController
    def index
        posts = Post.all
        render json: posts.to_json(include: [:user], except: [:updated_at])
    end

    def index_by_group
        post = Post.where("post_id = ?", params[:post_id])
        render json: post.to_json(include: [:user], except: [:updated_at])
    end

    def create
        post = Post.create(set_params)
        post["likes"] = 0
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
