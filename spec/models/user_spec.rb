require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @name = Gimei.name
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nickname、email、password、password_confirmation、
      family_name、first_name、family_name_kana、first_name_kana、birthdayが存在するなら登録できる' do
        expect(@user).to be_valid
      end
      it 'family_nameとfirst_nameが平仮名だけでも登録できる' do
        @user.family_name = @name.last.hiragana
        @user.first_name = @name.first.hiragana
        expect(@user).to be_valid
      end
      it 'family_nameとfirst_nameが全角カタカナだけでも登録できる' do
        @user.family_name = @name.last.katakana
        @user.first_name = @name.first.katakana
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it '重複したemailが存在すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'testgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'passwordが存在してもpassword_confirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = @user.password.to_s + 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'passwordが半角英字だけだと登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
      it 'passwordが半角数字だけだと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
      it 'family_nameが空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name can't be blank", 'Family name is invalid'
      end
      it 'family_nameが全角（漢字・ひらがな・カタカナ）でない文字が含まれているなら登録できない' do
        @user.family_name = Faker::Name.last_name
        @user.invalid?
        expect(@user.errors.full_messages).to include 'Family name is invalid'
      end
      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank", 'First name is invalid'
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でない文字が含まれているなら登録できない' do
        @user.first_name = Faker::Name.first_name
        @user.invalid?
        expect(@user.errors.full_messages).to include 'First name is invalid'
      end
      it 'family_name_kanaが空だと登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name kana can't be blank", 'Family name kana is invalid'
      end
      it 'family_name_kanaが全角カタカナでない文字が含まれているなら登録できない' do
        @user.family_name_kana = Faker::Name.last_name
        @user.invalid?
        expect(@user.errors.full_messages).to include 'Family name kana is invalid'
      end
      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank", 'First name kana is invalid'
      end
      it 'first_name_kanaが全角カタカナでない文字が含まれているなら登録できない' do
        @user.first_name_kana = Faker::Name.first_name
        @user.invalid?
        expect(@user.errors.full_messages).to include 'First name kana is invalid'
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
