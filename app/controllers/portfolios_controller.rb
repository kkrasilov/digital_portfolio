class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: :show
  def index
    @portfolios =
      if params[:q].present?
        filter_ilike_any_of(Portfolio.eager_load(:user).all, field_list: %w[users.first_name users.last_name users.surname users.position], searchable: params[:q])
      else
        Portfolio.all
      end

  end

  def show

  end

  private

  def filter_ilike_any_of(scope, field_list: [], searchable: nil)
    scope.where(field_list.map! { _1 + ' ~~* :searchable' }.join(' or '), searchable: "%#{searchable}%")
  end

  def set_portfolio
    @portfolio = Portfolio.find_by(id: params[:id])
    redirect_to root_path, notice: I18n.t('notice.not_found') if @portfolio.blank?
  end
end
