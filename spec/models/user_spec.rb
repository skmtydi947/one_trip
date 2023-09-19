# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'name,email,password,password_confirmationがあれば登録できる' do
    expect(@user).to be_valid
  end

  it 'nameが空だと登録できない' do
    @user.name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include('名前を入力してください')
  end

  it 'emailが空だと登録できない' do
    @user.email = nil
    @user.valid?
    expect(@user.errors.full_messages).to include('Eメールを入力してください')
  end

  it 'emailに@がないと登録できない' do
    @user.email = 'testexample.com'
    @user.valid?
    expect(@user.errors.full_messages).to include('Eメールには＠を含めてください')
  end

  it 'emailが重複していると登録できない' do
    @user.save
    another_user = FactoryBot.build(:user, email: @user.email)
    another_user.valid?
    expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
  end

  it 'passwordが空だと登録できない' do
    @user.password = nil
    @user.valid?
    expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワード（確認用）とパスワードの入力が一致しません')
  end

  it 'passwordが5文字以下だと登録できない' do
    @user.password = 'abc12'
    @user.password_confirmation = 'abc12'
    @user.valid?
    expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
  end

  it 'passwordに半角数字が最低1文字入力されていないと登録できない' do
    @user.password = 'aaaaaa'
    @user.password_confirmation = 'aaaaaa'
    @user.valid?
    expect(@user.errors.full_messages).to include('パスワードは不正な値です')
  end

  it 'passwordに半角英字が最低1文字入力されていないと登録できない' do
    @user.password = '123456'
    @user.password_confirmation = '123456'
    @user.valid?
    expect(@user.errors.full_messages).to include('パスワードは不正な値です')
  end

  it 'passwordとpassword_confirmationが異なると登録できない' do
    @user.password = 'abc123'
    @user.password_confirmation = '123abc'
    @user.valid?
    expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
  end

end
