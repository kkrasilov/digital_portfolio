class AwardsController < ApplicationController
  def create
    award = Award.new(award_params)
    if award.save
      redirect_to portfolio_path(award_params[:portfolio_id]), notice: I18n.t('notice.updated')
    else
      flash[:error] = []
      award.errors.full_messages.each {  flash[:error] << _1 }
      redirect_to portfolio_path(award_params[:portfolio_id])
    end
  end
  
  def update
    award = Award.find(params[:id])
    if award.update(award_params)
      redirect_to portfolio_path(award_params[:portfolio_id]), notice: I18n.t('notice.updated')
    else
      flash[:error] = []
      award.errors.full_messages.each {  flash[:error] << _1 }
      redirect_to portfolio_path(award_params[:portfolio_id])
    end
  end
  
  def new
    render json: { partial: render_to_string('_award', layout: false, locals: { award: Award.new(portfolio_id: params[:portfolio_id]) } ) }
  end
  
  def edit
    render json: { partial: render_to_string('_award', layout: false, locals: { award: Award.find(params[:id]) } ) }
  end
  
  def destroy
    Award.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end
  
  private
  
  def award_params
    params.require(:award).permit(:title, :description, :file, :portfolio_id)
  end
end
