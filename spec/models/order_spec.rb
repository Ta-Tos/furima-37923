require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:order, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order.building_name = nil
        expect(@order).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空だと保存できないこと' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空だと保存できないこと' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order.postal_code = 1_111_111
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'postal_codeが全角では保存できないこと' do
        @order.postal_code = '１２３−４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'prefectureを選択していないと保存できないこと' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空だと保存できないこと' do
        @order.municipality = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'address_numberが空だと保存できないこと' do
        @order.address_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Address number can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10桁未満だと保存できないこと' do
        @order.phone_number = 123_456_789
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is too short')
      end

      it 'phone_numberが11桁より多いと保存できないこと' do
        @order.phone_number = 123_456_789_010
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is too long')
      end

      it 'phone_numberが全角の数字だと保存できないこと' do
        @order.phone_number = '１２３４５６７８９１０'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'phone_numberが数字以外だと保存できないこと' do
        @order.phone_number = 'あいうえおかきくけこさ'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'userが紐付いていないと保存できないこと' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
