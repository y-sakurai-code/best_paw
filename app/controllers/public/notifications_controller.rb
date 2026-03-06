class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notification = current_user.passive_notifications.find(params[:id])
    @notification.destroy
    redirect_to notifications_path, notice: "通知を削除しました"
  end

  def destroy_all
    current_user.passive_notifications.destroy_all
    redirect_to notifications_path, notice: "通知をすべて削除しました"
  end


end
