class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).update_all(checked: true)
  end
end
