class UsersController < ApplicationController

  def mypage
    @user = current_user
    @reviews = Review.where(user_id: current_user.id)
  end

  def edit
  end

  def update
  end

  def show
  end

  def archive
  end

end
