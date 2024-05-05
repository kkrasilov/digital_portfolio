class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_last_seen_at, if: -> { current_user.present? && current_user.last_seen_at&.to_date != Date.today }
  before_action :assert_path_allowed

  rescue_from StandardError, with: :log_error

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[login email first_name surname position])
  end

  private

  def assert_path_allowed
    redirect_to guests_path unless current_user.present? || token.present?
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

  def log_error(exp)
    log = LogInfo.create(title: "#{self.class.name}##{action_name}", data: { exp: exp.message })
    flash[:error] = I18n.t('controllers.application.error', code: log.id)
    redirect_to root_path
  end
                                        
  def update_last_seen_at
    current_user.update_attribute(:last_seen_at, Time.current)
  end
end
