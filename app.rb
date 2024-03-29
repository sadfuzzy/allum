require 'gollum/app'
require 'digest/sha1'

class App < Precious::App
  User = Struct.new(:name, :email, :password_hash, :can_write)

  before { authenticate! }
  before /^\/(edit|create|delete|livepreview|revert)/ do authorize_write!; end

  helpers do
    def authenticate!
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @user = detect_user(@auth.credentials)

      unless @auth.provided? && @auth.basic? && @auth.credentials && @user
        response['WWW-Authenticate'] = %(Basic realm="Allum Wiki")
        throw(:halt, [401, "Not authorized\n"])
      end

      return @user
    end

    def authorize_write!
      throw(:halt, [403, "Forbidden\n"]) unless @user.can_write
    end

    def users
      @users ||= settings.authorized_users.map { |u| User.new(*u) }
    end

    def detect_user(credentials)
      users.detect do |u|
        [u.email, u.password_hash] == [credentials[0], Digest::SHA1.hexdigest(credentials[1])]
      end
    end
  end

  def commit_message
    {
      message:  params[:message],
      name:     @user.name,
      email:    @user.email
    }
  end
end