# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    password = Faker::Internet.password(min_length: 6)
    @user = User.new(
      name: Faker::Name.initials(number: 3),
      email: Faker::Internet.free_email,
      password: password,
      password_confirmation: password
    )
  end

  it 'name,email,password,password_confirmationがあれば登録できる' do
    expect(@user).to be_valid
  end

  it 'nameが空だと登録できない' do
    @user.name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include('名前を入力してください')
  end

  it 'emailに@がないと登録できない' do
    @user.email = 'testexample.com'
    @user.valid?
    expect(@user.errors.full_messages).to include('Eメールは不正な値です')
  end

end
