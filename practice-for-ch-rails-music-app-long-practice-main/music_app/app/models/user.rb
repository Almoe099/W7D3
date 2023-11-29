class User < ApplicationRecord

  before_validation :ensure_session_token

  validates :email, :session_token, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true


  attr_reader :password

  def self.find_by_credentials(email, password)

    User = User.find_by(email: email)

    if user && user.is_password?(password)
      user
    else
      nil
    end

    # user && user.is_password?(password) ? user : nil

  end


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pass_obj = BCrypt::Password.new(password_digest)
    pass_obj.is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end


  private

  def generate_session_token
    self.session_token = SercureRandom::urlsafe_base64
    return session_token unless User.exist?(session_token: session_token)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

end