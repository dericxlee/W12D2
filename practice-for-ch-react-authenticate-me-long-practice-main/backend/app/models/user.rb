class User < ApplicationRecord
    has_secure_password
    validates :username, :email, :password_digest, presence:true
    validates :password, length: {minimum: 6}, allow_nil:true

    before_validation :ensure_session_token

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if(@user&.authenticate(password))
            return @user
        else
            return nil
        end
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def reset_session_token
        self.session_token = generate_session_token
        self.save!
        return self.session_token
    end

    private

    def generate_session_token
        token = SecureRandom::urlsafe_base64(16)
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64(16)
        end
        return token
    end
end
