module Api
  class BaseController < ActionController::Base
    skip_before_action :verify_authenticity_token

    private

    def current_user
      @current_user ||= User.find_by_token(params[:token])
    end

    def authenticate_user!
      unauthorized 'authentication failed' unless current_user
    end

    def unauthorized(reason)
      render status: :unauthorized, json: { error: reason }
    end

    def bad_request(reason)
      render status: :bad_request, json: { error: reason }
    end
  end
end
