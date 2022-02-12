module SessionsHelper
  def log_in(position)
    session[:id] = position.id
    session[:member_id] = encrypt(position.member_id)
    @member = Member.find(decrypt(session[:member_id]))
    session[:token] = encrypt(@member.access_token)
  end

  def current_user
    @current_user ||= Permission.joins(:member, :role).where('permissions.permission_id = ?', session[:id]).select('*').first
    if (user_id = session[:id])
      @current_user ||= Permission.joins(:member, :role).where(id: user_id).select('*').first
    elsif (user_id = cookies.signed[:id])
      user = Permission.joins(:member, :role).where(id: user_id).select('*').first
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def token?
    @member = Member.find(decrypt(session[:member_id]))
    if decrypt(session[:token]) == @member.access_token
      decrypt(session[:token]).present?
    end
    # current_user.access_token.present?
  end

  def log_out
    # forget(current_user)
    # UserActivity.create! username: current_user.username, activity: "Logout", time: Time.now

    # session.delete(:user_id)
    reset_session
    @current_user = nil
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.user_id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  private

  def encrypt text
    text = text.to_s unless text.is_a? String

    len   = ActiveSupport::MessageEncryptor.key_len
    salt  = SecureRandom.hex(128)
    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    encrypted_data = crypt.encrypt_and_sign text
    "#{salt}$$#{encrypted_data}"
  end

  def decrypt text
    salt, data = text.split "$$"

    len   = ActiveSupport::MessageEncryptor.key_len
    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    coba = crypt.decrypt_and_verify data
    return coba
  end
end
