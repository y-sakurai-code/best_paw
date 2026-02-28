class Admin::UsersManagementsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end

  def soft_destroy
    user = current_user
    user.withdraw
    reset_session
    redirect_to admin_dashboards_path, notice: "退会処理が完了しました"
  end

  def withdraw
    update(email: "#{email}_deleted_#{Time.current.to_i}")
    discard
  end
    
  def show
    @user = User.find(params[:id])
  end

end
