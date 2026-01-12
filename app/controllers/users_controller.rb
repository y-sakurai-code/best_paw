class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit]

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

  def destroy
    user = current_user
    user.destroy
    redirect_to new_user_registration_path, notice: "退会処理が完了しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.nil? || @user.id != current_user.id
      redirect_to users_mypage_path, notice: "アクセス権限がないか、ユーザーが存在しません。"
    end
  end

end
