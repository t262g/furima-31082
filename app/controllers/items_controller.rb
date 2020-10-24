class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :identify_user, only: [:edit]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
    @item = Item.find(params[:id])
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
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @image = @item.image

    if params[:item][:image] == nil
      params[:item][:image] = @image 
    end

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :explanation,
                                 :category_id, :condition_id, :shipping_cost_id, :area_id, :delivery_day_id)
          .merge(user_id: current_user.id)
  end

  def identify_user
    if current_user != Item.find(params[:id]).user
      redirect_to root_path
    end
  end
end
