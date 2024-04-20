class UsersController < ApplicationController
  def profile; end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to profile_users_path, notice: 'Данные обновлены!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
