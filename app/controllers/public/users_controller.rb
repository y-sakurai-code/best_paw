class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit]

  def mypage
    @user = current_user
    @dogs = @user.dogs
    @reviews = @user.reviews.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to user_path(current_user.id), notice: "更新しました"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @dogs = @user.dogs
  end

  def destroy
    user = current_user
    user.withdraw
    reset_session
    redirect_to new_user_registration_path, notice: "退会処理が完了しました"
  end

  def archive
    @dog = current_user.dogs.find(params[:id])
    @dog.update(is_archived: true)
    redirect_to users_mypage_path(current_user), notice: "#{@dog.name}を思い出箱へ移動しました。"
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
