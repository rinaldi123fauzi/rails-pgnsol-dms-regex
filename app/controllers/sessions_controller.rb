class SessionsController < ApplicationController
  # TOKEN = "Pg4S50lut10n!!!"
  # protect_from_forgery :except => [:create, :destroy, :switch_role]
  protect_from_forgery
  # skip_before_action :verify_authenticity_token, :only => [:create]
  # skip_before_action :logged_in_user
  before_action :logged_in_user, except: [:new, :create]
  after_action :set_access_token, only: [:destroy]
  # before_action :authenticate, except: [ :new ]
  # before_action :logged_in_user
  # skip_authorization_check :only => [:new, :create]

  def new
    if logged_in?
      redirect_to root_path
    else
      login_url
    end
  end

  def create
    setLoginProcess
  end

  def destroy
    if current_user.username.present?
      ldap = Net::LDAP.new :host => '192.168.60.159',
                           :port => 389,
                           :auth => {
                               :method => :simple,
                               :username => "cn=manager, dc=pgn-solution, dc=co, dc=id",
                               :password => "4lh4mdul1ll4h"
                           }
      filter = Net::LDAP::Filter.eq("cn", "#{current_user.username}")
      treebase = "dc=pgn-solution, dc=co, dc=id"
      ldap.search(:base => treebase, :filter => filter) do |entry|
        if current_user.username == entry["sn"].map(&:inspect).join(', ').gsub('"', '')
          login_activity current_user.nama + " has been logout "
        end
      end
    end
    redirect_to login_url, notice: "Success logout"
  end

  def switch_role
    some_parameter = params[:some_parameter]
    session.delete(:id)
    @permission = Permission.find_by(permission_id: some_parameter)
    session[:id] = @permission.permission_id
    @current_user ||= Permission.joins(:member, :role).where('permissions.permission_id = ?', session[:id]).select('*')
    if (user_id = session[:id])
      @current_user ||= permission.joins(:member, :role).where('permissions.permission_id = ?', user_id).select('*')
    elsif (user_id = cookies.signed[:id])
      user = Permission.joins(:member, :role).where(permission_id: user_id).select('*')
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    respond_to do |format|
      format.html
      format.json { render json: @permission.permission_id }
    end
  end

  private

  def getPrivateIpAddress
    return request.remote_ip.to_s == '192.168.60.1'
  end

  def setLoginProcess
    # if verify_recaptcha
      ldap = Net::LDAP.new
      #ldap.host = '192.168.192.2' # LDAP LAMA
      ldap.host = '192.168.60.159' # LDAP BARU
      ldap.port = 389
      ldap.auth 'uid=' + CGI.escapeHTML(params[:username].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", "")) + ', ou=people, dc=pgn-solution, dc=co, dc=id', CGI.escapeHTML(params[:password].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", ""))
      user = Member.find_by(username: "#{CGI.escapeHTML(params[:username].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", "")).downcase}")
      if ldap.bind
        if user != nil
          log_in user
          getLoginLDAP
        else
          setNewUserFromLDAP
        end
      else
        getLoginInternal
      end
    # else
    #   redirect_to login_url, alert: "PLEASE ENTRY CAPTCHA"
    # end
  end

  def setNewUserFromLDAP
    user = Member.new
    user.username = params[:username]
    user.email = params[:username] + '@pgn-solution.co.id'
    user.password = params[:password]
    user.access_token = encrypt('PGN50lut10n!')
    user.status = "Active"
    @nama = params[:username].gsub(".", " ")
    @nama = @nama.upcase
    user.nama = @nama
    user.save
    @user = Member.find_by(username: params[:username])
    permission = Permission.new
    permission.member_id = @user.member_id
    permission.role_id = 10
    if permission.save
      @position = Permission.where(member_id: @user.member_id).first
      log_in @position
      permission = Permission.where(permission_id: session[:id]).first
      login_activity current_user.nama + " has been login "
      if permission.is? 10 # Off
        redirect_to root_path
      else
        redirect_to login_url, alert: "Username / Password anda salah"
      end
    else
      redirect_to login_url, alert: "Username / Password anda salah"
    end
  end

  def getLoginLDAP
    user = Member.find_by(username: "#{CGI.escapeHTML(params[:username].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", "")).downcase}")
    user.password = CGI.escapeHTML(params[:password].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", ""))
    user.password_confirmation = CGI.escapeHTML(params[:password].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", ""))
    user.save
    if user.status === "Active"
      @position = Permission.where(member_id: user.member_id).first
      if @position.present?
        log_in @position
        permission = Permission.where(permission_id: session[:id]).first
        login_activity current_user.nama + " has been login "
        if permission.is? 1 # Off
          session.delete(:id)
          redirect_to login_url
        elsif permission.is? 2 # Admin
          redirect_to root_path
        elsif permission.is? 6 # Inputer QM
          redirect_to root_path
        elsif permission.is? 7 # Inputer WR
          redirect_to root_path
        elsif permission.is? 10 # Staff
          redirect_to root_path
        elsif permission.is? 19 # Staff
          redirect_to root_path
        end
      else
        redirect_to login_url, alert: "The role is not set for this account"
      end
    else
      redirect_to login_url, alert: "account anda salah"
    end
  end

  def getLoginInternal
    user = Member.find_by_username(CGI.escapeHTML(params[:username].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", "")).downcase)
    if user and user.authenticate(CGI.escapeHTML(params[:password].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", "")))
      #   # session[:user_id] merupakan variabel global yang digunakan sebagai variabel untuk menyeleksi data berdasarkan session aktif
      if user.status === "Active"
        @position = Permission.where(member_id: user.member_id).first
        if @position.present?
          log_in @position
          permission = Permission.where(permission_id: session[:id]).first
          if permission.is? 1 # Off
            session.delete(:id)
            redirect_to login_url
          elsif permission.is? 2 # Admin
            redirect_to root_path
          elsif permission.is? 6 # Inputer QM
            redirect_to root_path
          elsif permission.is? 7 # Inputer WR
            redirect_to root_path
          elsif permission.is? 10 # Staff
            redirect_to root_path
          elsif permission.is? 19 # Staff
            redirect_to root_path
          end
        else
          redirect_to login_url, alert: "The role is not set for this account"
        end
      else
        redirect_to login_url, alert: "account anda salah"
      end
    else
      redirect_to login_url, alert: "account anda salah"
    end
  end

  def set_access_token
    @member = Member.find(current_user.member_id)
    @member.update(access_token: encrypt('PGN50lut10n!'))
    log_out
    # self.access_token = encrypt('PGN50lut10n!')
  end

  def encrypt text
    text = text.to_s unless text.is_a? String

    len = ActiveSupport::MessageEncryptor.key_len
    salt = SecureRandom.hex len
    # @member = Member.find(current_user.member_id)
    # salt  = @member.password_digest
    key = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    encrypted_data = crypt.encrypt_and_sign text
    "#{salt}$$#{encrypted_data}"
  end
end
