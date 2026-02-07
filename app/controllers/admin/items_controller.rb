class Admin::ItemsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.admin_id = current_admin.id
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました"
    else
      render plain: @item.errors.full_messages
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品を更新しました"
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :estimated_dog_size, :is_active, :item_image)
  end

end
