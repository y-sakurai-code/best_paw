class Public::DogsController < ApplicationController
  before_action :authenticate_user!

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id
    if @dog.save
      redirect_to users_mypage_path, notice: "愛犬を登録しました！"
    else
      render :new
    end
  end

  def edit
    @dog = current_user.dogs.find(params[:id])
  end

  def update
    @dog = current_user.dogs.find(params[:id])
    
    if params[:dog][:image_del] == '1'
      @dog.dog_image.purge
    end

    if @dog.update(dog_params)
      redirect_to users_mypage_path(current_user), notice: "愛犬の情報を更新しました！"
    else
      render :edit
    end
  end

  def archive
    @dog = current_user.dogs.find(params[:id])
    @dog = Dog.find(params[:id])
      if @dog.is_archived
        @dog.update(is_archived: false, archived_date: nil)
        notice_message = "プロフィールに戻しました。"
      else
        @dog.update(is_archived: true, archived_date: Date.today)
        notice_message = "思い出箱に移動しました。"
      end
      redirect_back fallback_location: users_mypage_path, notice: notice_message
  end

  def destroy
    @dog = current_user.dogs.find(params[:id])
    @dog.destroy
    redirect_to users_mypage_path(current_user), notice: "愛犬のデータを削除しました"
  end

  def memorial
    @archived_dogs = current_user.dogs.where(is_archived: true)
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :birthday, :size, :dog_image, :gender).tap do |d|
      d[:size] = d[:size].to_i if d[:size].present?
    end
  end

end
