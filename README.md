<h1 align="center">One Trip</h1>

# アプリケーションの概要
- 旅行が趣味という方や最近旅行に行っていない方向けに作成した旅行の思い出を共有するアプリです。
- 旅行先で撮影した写真をアップする機能やいいね機能、フォロー機能などを実装しました。
- GoogleMapAPIを導入し、投稿された場所のルートを検索できます。
- レスポンシブにも対応させ、スマートフォンでもご覧いただきやすく実装しておりますのぜひPC、スマートフォンの両方でご確認ください。

# 開発環境
言語：Ruby (2.6.4)

フレームワーク：Ruby on Rails (6.1.7)

フロントエンド：HTML/CSS/Bootstrap/JavaScript/jQuey

DB：PostgreSQL

インフラ：AWS（S3）

ソースコードの管理：GitHub

テキストエディタ：Visual Studio Code

# 本番環境

### URL
https://one-trip.onrender.com

ゲストログイン機能を実装しておりますので、新規登録なしでご覧いただけます。

## ローカルでの動作手順	
```ターミナル
git clone https://github.com/skmtydi947/one_trip.git
cd one_trip
bundle install
rails db:create
rails db:migrate
```

# 利用方法
・トップページからゲストログインをクリックすると投稿一覧画面に遷移します。

・ヘッダーの投稿するをクリックすると新規投稿画面へ遷移します。
・必要情報を入力し、投稿するをクリック
・投稿詳細ページへ遷移します。

・投稿詳細画面にていいねをすることができます。

・投稿詳細画面のMAPピンをクリックすると旅行先名が表示されます。
・追加をクリックすると、< ルート検索リスト >に追加されルート検索をクリックすると２点間の距離と時間が表示されます。（複数選択可）
・マップには経路が描写されます。

・メッセージを入力して送信するをクリックするとコメントできます。
・削除をクリックすることで削除できます。

・ユーザー詳細ページでユーザーのフォローができます。

# 制作背景
## 開発の意図
本アプリケーションは、旅先を決める際の「どこに行こう」、「何をしよう」を解決し、同じ旅先でも前回とは異なる体験をしていただけたらいいなという思いを込めて作成しました。

同じ場所の写真でも投稿した人それぞれの視点で捉え方が違ったり、行く時期によっても印象が大きく変わったりします。本アプリの投稿から同じ場所でも新たな側面をしれて「もう一度次はこの季節に行ってみようかな」と思ってもらったり「行く時期によってはイベントがあったりするんだ」というふうに旅が楽しみになってもらいたいと思っています。

# 工夫したポイント
- ユーザーが直感的に使用できるようシンプルなデザインを意識しました。
- ユーザー間でコミュニケーションをとってもらえるように投稿へのコメント機能を実装しました。
- 投稿した側が投稿への意欲を失わず継続的な利用が促されるように、投稿に対するいいね数を表示するようにしました。
- GoogleMapAPIを導入し、投稿画面にマップを表示させることで旅行のイメージを持ってもらいやすくしました。
- ルートの検索機能により距離と時間を表示させることで計画を立てるのに役立てることができます。

# 実装予定の機能
- いいねした投稿のみをマップに表示させる
- 投稿一覧画面に検索フォームを実装
- ルート検索機能の結果を移動手段によって切り替える

# 機能一覧
|機能|概要|
|----|----|
|ユーザー管理機能|新規登録・ログイン・ログアウトできます|
|簡単ログイン機能|トップ画面のゲストログインから新規作成せずにログインできます可能です|
|投稿機能|旅行のタイトル,旅行先の名前（例：スカイツリー）か住所、旅行の感想と画像を8枚まで投稿できます|
|投稿詳細表示機能|投稿の詳細を確認できます|
|投稿編集|投稿者本人のみ投稿編集可能です（ゲストユーザーは修正不可）|
|ユーザー一覧表示機能|登録したユーザーの一覧を閲覧できます|
|ユーザー情報編集機能|ログイン中のユーザーかつ本人であればプロフィールを編集できます|
|フォロー機能|ユーザー一覧画面から各ユーザーのフォローできます|
|フォロー一覧表示機能|フォローしているまたはフォローされているユーザーを閲覧できます|
|いいね機能|投稿詳細ページからいいね!（非同期）できます|
|コメント機能|投稿詳細ページからコメント（非同期）できます|
|マップ表示機能|投稿画面で入力した住所の経度・緯度を自動で取得し、マップで表示することができます|
|ルート検索機能|投稿詳細画面のMAPのピンを選択し地点間の距離と時間を取得できます。|
|レスポンシブデザイン|スマートフォン向けにボトムナビゲーションバーを表示します|

# DB設定
