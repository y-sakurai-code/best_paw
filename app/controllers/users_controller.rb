class UsersController < ApplicationController

  def mypage
    @user = current_user
    @reviews = Review.where(user_id: current_user.id)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_user_path(current_user.id), notice: "更新しました"
    else
      render :edit
    end
  end

  def show
    @user = current_user
  end

  def archive
    user = User.find(params[:id])
    user.archive
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
