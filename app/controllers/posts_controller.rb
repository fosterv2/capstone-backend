class PostsController < ApplicationController
    def index
        posts = Post.all
        render json: posts.to_json(include: [:user, :groups, :likes], except: [:updated_at])
    end

    def create
        post = Post.create(content: params[:content], user_id: params[:user_id], post_img: params[:post_img])
        post.group_ids = params[:group_ids]
        if params[:image] != "null"
            image = Cloudinary::Uploader.upload(params[:image])
            post.post_img = image["url"]
        end
        render json: post.to_json(include: [:user, :groups, :likes], except: [:updated_at])
    end

    def update
        post = Post.find(params[:id])
        post.update(set_params)
        post.group_ids = params[:group_ids]
        render json: post.to_json(include: [:user, :groups, :likes], except: [:updated_at])
    end

    def add_like
        Like.create(user_id: params[:user_id], post_id: params[:post_id])
        post = Post.find(params[:post_id])
        render json: post.to_json(include: [:user, :groups, :likes], except: [:updated_at])
    end

    def destroy
        post = Post.find(params[:id])
        post.update(set_params)
        render json: post.to_json(include: [:user, :groups, :likes], except: [:updated_at])
    end

    private

    def set_params
        params.require(:post).permit(:content, :user_id, :post_img, :deleted)
    end
end
