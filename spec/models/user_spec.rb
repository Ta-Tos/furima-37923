require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'すべて正しい値が入力されていれば保存できる' do
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'nicknameが空だと保存できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空だと保存できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '既に登録されているemailは保存できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailには@が含まれていること' do
        @user.email = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では保存できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordは6文字以上出ないと保存できないこと' do
        @user.password = 'as123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordは半角英字のみでは保存できないこと' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordは半角数字のみでは保存できないこと' do
        @user.password = '111111'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordは全角では保存できないこと' do
        @user.password = 'ああああああ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordと確認用passwordが一致しないと保存できないこと' do
        @user.password_confirmation = '12345a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'family_nameが空では保存できないこと' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'family_nameの入力が全角（漢字、ひらがな、カタカナ）出ないと保存できないこと' do
        @user.family_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid. Input full-width characters.')
      end

      it 'first_nameが空では保存できないこと' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameの入力が全角（漢字、ひらがな、カタカナ）出ないと保存できないこと' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end

      it 'family_kana_nameが空では保存できないこと' do
        @user.family_kana_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family kana name can't be blank")
      end

      it 'family_kana_nameが全角（カタカナ)出ないと保存できないこと' do
        @user.family_kana_name = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family kana name is invalid. Input full-width katakana characters.')
      end

      it 'first_kana_nameが空では保存できないこと' do
        @user.first_kana_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana name can't be blank")
      end

      it 'first_kana_nameが全角（カタカナ）出ないと保存できないこと' do
        @user.first_kana_name = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First kana name is invalid. Input full-width katakana characters.')
      end

      it 'birthdayが空では保存できないこと' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
