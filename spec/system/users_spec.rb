require 'rails_helper'

RSpec.describe '新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力すれば、新規登録できる' do
      # トップページに遷移
      visit root_path
      # ヘッダーに新規登録ボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録画面に遷移する
      visit new_user_registration_path
      # 必須項目の入力
      fill_in '名前', with: @user.name
      fill_in 'Eﾒｰﾙ', with: @user.email
      fill_in 'ﾊﾟｽﾜｰﾄﾞ(6文字以上)', with: @user.password
      fill_in 'ﾊﾟｽﾜｰﾄﾞ（確認用）', with: @user.password_confirmation
      # 新規登録ボタンをクリックするとユーザーモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # 登録が完了すると、投稿一覧ページに遷移
      expect(current_path).to eq(posts_path)
      # ページにアカウント登録が完了しました。と表示される
      expect(page).to have_content("アカウント登録が完了しました。")
    end
  end
end
