class PurchasesController < ApplicationController
  def index
    find_item
    @user_purchase = UserPurchase.new
  end

  def create
    find_item
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      @user_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private 

  def find_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :area_id, :city, :address_line_1, :address_line_2, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
end
