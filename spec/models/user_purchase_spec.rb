require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  before do
    @user_purchase = FactoryBot.build(:user_purchase)
  end

  describe '商品購入機能' do
    context '商品の購入がうまくいくとき' do
      it '全ての情報が正しく入力されると購入がうまくいく' do
        expect(@user_purchase).to be_valid
      end
      it 'address_line_2が空でも購入がうまくいく' do
        @user_purchase.address_line_2.nil?
        expect(@user_purchase).to be_valid
      end
    end

    context '商品の購入がうまくいかないとき' do
      it '郵便番号が空だとうまくいかない' do
        @user_purchase.postal_code = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include "Postal code can't be blank", 'Postal code is invalid. Include hyphen(-)'
      end
      it '郵便番号にハイフンが入っていないとうまくいかない' do
        @user_purchase.postal_code = '1111111'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '都道府県が空だとうまくいかない' do
        @user_purchase.area_id = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include "Area can't be blank"
      end
      it '市区町村が空だとうまくいかない' do
        @user_purchase.city = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空だとうまくいかない' do
        @user_purchase.address_line_1 = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include "Address line 1 can't be blank"
      end
      it '電話番号が空だとうまくいかない' do
        @user_purchase.phone_number = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include "Phone number can't be blank"
      end
      it '電話番号が全角数字だとうまくいかない' do
        @user_purchase.phone_number = '０１２３４５６７８９０'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号が12桁以上だとうまくいかない' do
        @user_purchase.phone_number = '012345678901'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号にハイフンが入っているとうまくいかない' do
        @user_purchase.phone_number = '123-4567-8910'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it 'priceが無いとうまくいかない' do
        @user_purchase.price = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include "Price can't be blank"
      end
      it 'tokenが無いとうまくいかない' do
        @user_purchase.token = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include "Token can't be blank"
      end
    end
  end
end
