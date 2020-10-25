class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :identify_user, only: :edit
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @image = @item.image

    params[:item][:image] = @image if params[:item][:image].nil?

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :explanation,
                                 :category_id, :condition_id, :shipping_cost_id, :area_id, :delivery_day_id)
          .merge(user_id: current_user.id)
  end

  def identify_user
    redirect_to root_path if current_user != Item.find(params[:id]).user
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
