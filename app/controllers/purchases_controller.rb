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
      pay_item
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
    redirect_to root_path unless @item.purchase.nil?
  end

  def identify_user
    redirect_to root_path if current_user == @item.user
  end

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :area_id, :city,
                                          :address_line_1, :address_line_2, :phone_number)
          .merge(price: @item.price, token: params[:token],
                 user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: purchase_params[:price],
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
