class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @total_user_count = User.count
    @today_user_count = User.where(created_at: Time.zone.now.all_day).count

    @total_item_count = Item.count
    @total_review_count = Review.count

    @recent_reviews = Review.includes(:user).order(created_at: :desc).limit(10)
  end

end
