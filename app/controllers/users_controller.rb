class UsersController < ApplicationController
  def show
    common
  end

  def articles
    common
  end

  def change_profile
    Rails.cache.delete "current_user_[#{current_user.id}]" if current_user
  end

  def update_profile
    Rails.cache.delete "current_user_[#{current_user.id}]" if current_user
    if current_user.update(user_params)
      flash[:success] = "更新成功"
      redirect_to change_profile_users_path
    else
      render :change_profile
    end
  end

  private

  def common
    @user = User.find(params[:id])
    # @favourite_articles = @user.like_articles.page(params[:page])
    @favourite_movies = @user.like_movies.order('id DESC').page(params[:page])
    # @favourite_softs = @user.like_softs
    @articles = @user.articles.order('id DESC').page(params[:page])
  end

  def user_params
    params.require(:user).permit(:username, :avatar, :nickname, :company_name, :position)
  end
end
