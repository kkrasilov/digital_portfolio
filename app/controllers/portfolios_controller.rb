class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: :show
  def index
    @portfolios = Portfolio.all
  end

  def show

  end
  
  private 
  
  def set_portfolio
    @portfolio = Portfolio.find_by(id: params[:id])
    redirect_to root_path, notice: I18n.t('notice.not_found') if @portfolio.blank?
  end
end
