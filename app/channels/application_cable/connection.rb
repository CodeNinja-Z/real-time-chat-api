module ApplicationCable
  class Connection < ActionCable::Connection::Base
    rescue_from StandardError, with: :report_error
    identified_by :current_user

    def connect
      Rails.logger.debug(request.params)
      self.current_user = find_verified_user(request.params[:token])
    end

    private

    def find_verified_user(token)
      decoded_auth_token ||= JsonWebToken.decode(token)
      user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token

      if user
        return user
      else
        return reject_unauthorized_connection
      end
    end

    def report_error(e)
      # SomeExternalBugtrackingService.notify(e)
    end
  end
end
