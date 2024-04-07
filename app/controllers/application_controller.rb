class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :assert_path_allowed

  rescue_from Errors::NotAuthorized, with: :forbidden
  rescue_from StandardError, with: :log_error

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[login email])
  end

  private

  def assert_path_allowed
    raise Errors::NotAuthorized unless current_user.present? || token.present?
  end

  def token_verification
    JWT.decode(params[:token], ENV.fetch('JWT_SECRET', 'jwt_secret')) rescue false
  end

  def token
    cookies[:jwt_token].presence || (token_verification && fetch_token[:value])
  end

  def fetch_token
    cookies[:jwt_token] = { value: params[:token], expires: 3.months.from_now }
  end

  def forbidden
    redirect_to guests_path
  end

  def log_error(exp)
    log = LogInfo.create(title: "#{self.class.name}##{action_name}", data: { exp: exp.message })
    flash[:error] = I18n.t('controllers.application.error', code: log.id)
    redirect_to root_path
  end
end
