class User < ApplicationRecord
    validates :password_digest, :username, :session_token, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }

    attr_reader :password
    has_many :links
    has_many :comments

    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            return user 
        else
            return nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        check_pass = BCrypt::Password.new(self.password_digest)
        check_pass.is_password?(password)
    end

    def self.generate_session_token
        SecureRandom.urlsafe_base64
    end

    def reset_session_token
        self.session_token = self.class.generate_session_token
        self.save
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end
end