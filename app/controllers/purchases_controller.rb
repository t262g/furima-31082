class PurchasesController < ApplicationController
  before_action :find_item, only: [:index, :create]

  def index
    check_purchase
    authenticate_user!
    identify_user
    @user_purchase = UserPurchase.new
  end

  def create
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

  def check_purchase
    if @item.purchase != nil
      redirect_to root_path
    end
  end

  def identify_user
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :area_id, :city, :address_line_1, :address_line_2, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

end
