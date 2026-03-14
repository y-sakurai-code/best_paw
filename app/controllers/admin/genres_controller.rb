class Admin::GenresController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを追加しました"
    else
      @genres = Genre.all
      render :index 
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "更新しました"
    else
      flash[:alert] = @genre.errors.full_messages.join(", ")
      redirect_to admin_genres_path, alert: "更新に失敗しました"
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path, notice: "ジャンルを削除しました"
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
