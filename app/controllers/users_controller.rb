class UsersController < ApplicationController
    def create
        byebug
        user = User.new(username: params[:username], owner_name: params[:owner_name], breed: params[:breed],
                img_url: params[:img_url], password: params[:password])
        if params[:image] != "null"
            image = Cloudinary::Uploader.upload(params[:image])
            post.update(post_img: image["url"])
        end
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
            render json: user.to_json(include: [:followers, :followees], except: [:created_at, :updated_at])
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

    def add_follower
        user = User.find(params[:user_id])
        Follow.create(follower_id: params[:user_id], followee_id: params[:follow_id])
        render json: user.to_json(include: [:followers, :followees], except: [:created_at, :updated_at])
    end

    def remove_follower
        user = User.find(params[:user_id])
        Follow.where("follower_id = ? AND followee_id = ?", params[:user_id], params[:follow_id])[0].destroy
        render json: user.to_json(include: [:followers, :followees], except: [:created_at, :updated_at])
    end

    # private

    # def set_params
    #     params.require(:user).permit(:username, :owner_name, :breed, :img_url, :password, :password_confirmation)
    # end
end

Started POST "/posts" for ::1 at 2020-07-28 12:21:50 -0700
Processing by PostsController#create as */*
Parameters: {"id"=>"undefined", "content"=>"My picture", "post_img"=>"", "group_ids"=>"", "user_id"=>"6",
"image"=>#<ActionDispatch::Http::UploadedFile:0x00007fa3a998fd60 @tempfile=#<Tempfile:/var/folders/8p/sh99mbbx5bs_3r0x36xmt7x00000gn/T/RackMultipart20200728-19512-1ojsgm7.jpg>, @original_filename="IMG_20200701_155036520.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"image\"; filename=\"IMG_20200701_155036520.jpg\"\r\nContent-Type: image/jpeg\r\n">}
  (1.2ms)  BEGIN