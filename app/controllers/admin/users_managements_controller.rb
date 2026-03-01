class Admin::UsersManagementsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @users = User.with_discarded.order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_managements_path, notice: 'ユーザーを削除しました。'
  end

  def withdraw
    update(email: "#{email}_deleted_#{Time.current.to_i}")
    discard
  end

  def soft_destroy
    @user = User.find(params[:id])
    @user.withdraw
    redirect_to admin_users_managements_path, notice: "ユーザー「#{@user.name}」を退会処理しました。"
  end

  def show
    @user = User.with_discarded.find(params[:id])
  end

  def undiscard
    @user = User.with_discarded.find(params[:id])
    if @user.restore
      redirect_to admin_users_management_path(@user), notice: "ユーザー「#{@user.name}」を復旧しました。"
    else
      redirect_to admin_users_management_path(@user), alert: "復旧に失敗しました。"
    end
  end

end
