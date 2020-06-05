class ApplicationController < ActionController::API
    def encode_token(payload)
        JWT.encode(payload, 'Tur2nip!')
    end

    def token
        request.headers['Authorization']
    end

    def decoded_token
        begin
            JWT.decode(token, 'Tur2nip!', true, { algorithm: 'HS256' })
        rescue JWT::DecodeError
            [{error: "Invalid Token"}]
        end
    end

    def current_user
        if decoded_token
            user_id = decoded_token.first['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!current_user
    end
end
