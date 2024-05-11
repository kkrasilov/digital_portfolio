class ArticlesController < ApplicationController
  def about
    @users = User.where(admin: true)
  end
end
