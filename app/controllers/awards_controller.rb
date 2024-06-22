class AwardsController < ApplicationController
  before_action :set_award, only: %i[edit update destroy]

  def new
    render json: { partial: render_to_string('_form', layout: false, locals: { award: current_user.portfolio.awards.new }) }
  end

  def create
    award = Award.new(award_params.merge(portfolio_id: current_user.portfolio.id))
    if award.save
      flash[:notice] = I18n.t('notice.updated')
    else
      flash[:error] = award.errors.full_messages
    end

    redirect_to portfolio_path(current_user.portfolio)
  end

  def edit
    render json: { partial: render_to_string('_form', layout: false, locals: { award: @award }) }
  end

  def update
    if @award.update(award_params)
      flash[:notice] = I18n.t('notice.updated')
    else
      flash[:error] = @award.errors.full_messages
    end

    redirect_to portfolio_path(current_user.portfolio)
  end

  def destroy
    @award.destroy
    redirect_back fallback_location: root_path
  end

  private

  def award_params
    params.require(:award).permit(:title, :description, :file, :portfolio_id)
  end

  def set_award
    @award = current_user.portfolio.awards.find_by(id: params[:id])
    render json: { error: 'not found' } if @award.blank?
  end
end
