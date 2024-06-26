■サービス概要
自身の所有する服の購入記録や使用記録、経年変化の記録をつけることで、服への愛情（価値）を増やすことができる。
自身の服の記録だけでなく他のユーザーの記録を閲覧することや、メッセージ、コメント、いいね機能などによるユーザー同士のコミュニケーションをとることができる、更に自身の服の記録を他のユーザーに譲ることができる。

■ このサービスへの思い・作りたい理由
このサービスの題材となるものに関してのエピソードがあれば詳しく教えてください。
このサービスを思いつくにあたって元となる思いがあれば詳しく教えてください。

私は前職で古着を仕事にしていたほど洋服が好きです。
長く一つの洋服を愛用していると、自分の身体に馴染んでより使いやすくなり、増えていく汚れなどもいい思い出になっていきます。
他の人の洋服に宿るエピソードを聞くことも好きで、そういった話を聞くことで、より一層その人のスタイルが素敵なものに感じられます。
このような経験をより簡単にできないかとアプリを探したところ、自身の洋服を管理し、似たような洋服の購入を防いだり、新しい着こなしを提案するものはありましたが、各々の洋服にまつわる歴史を残し、その思いを共有できるようなアプリは見つけられませんでした。
そこで、「無いのであれば作ってしまえ」と思い、今回のアプリ作成にいたりました。

■ ユーザー層について
    - 服に関心がある方。ものを大事にしたい方。
    - もともと服の記録をつけている、もしくはつけたいと思っていたがしていなかった人が一定数いると予想されるため。

■サービスの利用イメージ
ユーザーは自身の各洋服の記録を積み重ねることで洋服への愛着を増すことができる。
近しい感覚を持つユーザーとコミュニケーションを取ることができる。
総じて、リセールバリューなどを気にせず純粋にファッションとして洋服を楽しむことができるようになる。

■ ユーザーの獲得について
    - 自身がインスタグラム、X、notionで使用レポートの拡散

■ サービスの差別化ポイント・推しポイント
    - 洋服を管理しコーディネートや新たな洋服購入の提案を行ってくれる既存のサービスはあるが、１つの洋服に対して記録を重ねられるサービスは確認できていない。

■ 機能候補
### 画面遷移図
Figma：https://www.figma.com/file/5KVLOw2MFrDRsZ8rCeh4ki/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=82533pkcsE66yqzt-1

# MVPリリース時
- **基本機能**
    - ユーザー登録
    - ログイン
    - パスワード変更
- **洋服の記録**: ユーザーは自分の洋服を画像とともに記録できる
    - 画像保存
    - タグ付け（デニム、冬、夏、デートなど）
    - 洋服に関するエピソードの記録（テキストや写真で）
- **洋服の共有**: ユーザーは記録した洋服を他のユーザーと共有できる
    - 所有者ごとの検索
    - カテゴライズやタグによる検索
    - お気に入り登録
    - 譲る機能（自身の洋服の記録を任意の相手に渡す）
    - フォローユーザーの記録のタイムライン表示
    - タイムライン（他ユーザーの記録：時系列順にランダム）
- **コミュニケーション**: ユーザー間でコミュニケーションを取ることができる
    - メッセージ機能
    - コメント機能
    - フォロー機能

# 本リリース時
- **洋服の記録**: ユーザーは自分の洋服を画像とともに記録できる
    - 洋服データの可視化（グラフ管理）
- **コミュニケーション**: ユーザー間でコミュニケーションを取ることができる
    - 自動通知機能（フォローした人がデータを更新した場合や、洋服を譲りたくなった場合に通知が届く）
- **UI/UX**
    - 背景画像の自動変更（記録した洋服の色とカテゴリに応じて背景のイラストが自動で変化する）
    - AIによる洋服画像登録の一部自動化
      - 洋服画像への自動タグ付け（白、シャツ、デニム、コートなど）
      - アップロードした写真と同様のものがあれば、自動で提案（提案後に「はい」を押すと既存のアイテムデータに写真が追加される、「いいえ」なら任意で追加する既存アイテムか新規アイテムの追加を選択する）

■ 機能の実装方針予定
- **洋服データの可視化**
    - Chart.jsもしくはGoogle Chartsを使用予定
- **AIによる洋服画像登録の一部自動化**
    - Google Cloud Vision API（写真データからタグを提案、提案されたタグと一致する既存の洋服がある場合に既存の洋服に写真を追加することを提案）
- **背景画像の自動変更（記録した洋服の色とカテゴリに応じて背景のイラストがページ更新時に自動で変化する）**
    - Google Cloud Vision API(洋服の種類分け、色の抽出)
- **画像登録数や更新登録数に応じて独自背景をプレゼント**
    - 各ユーザーTOPページのデフォルト背景（クローゼットを想定）に加えて、画像登録数や更新登録数に応じて独自背景をプレゼント
- **メッセージ、コメント機能**
    - Action Cable WebSocket

- **譲る機能について（自身の洋服の記録を任意の相手に渡す）**
    - データベース設計
        - 所有権の追跡
            洋服データモデルに、どのユーザーがどの洋服を所有しているかを追跡するために現在の所有者を示すユーザーIDフィールドを追加
        - 譲渡履歴の記録
            譲渡履歴を記録するために譲渡元ユーザーID、譲渡先ユーザーID、洋服ID、譲渡日時などを含んだモデルを作成
    - 譲渡プロセスのフロー
        - 譲渡の開始
            譲渡元のユーザーが洋服を選択し、譲渡先ユーザーを指定して譲渡リクエストを送る
        - リクエストの通知と確認
            譲渡先ユーザーにリクエストが通知され、承認または拒否を選択
        - データの更新
            リクエストが承認された場合、譲渡元と譲渡先のユーザーIDと洋服IDを受け取り、データベースを更新


■ 想定しているメイン技術スタック
- **フロントエンド**
    - Hotwire
    - Google Charts
- **バックエンド**
    - Ruby on Rails
    - Ruby
- **データベース**
    - PostgreSQL
- **デプロイメント**
    - Heroku
- **画像ストレージ**
    - Amazon S3
- **バージョン管理**
    - Git/GitHub
- **API**
    - Google Cloud Vision API

# ER図
https://mermaid-js.github.io/mermaid-live-editor/view#pako:eNq1VltrE0EU_ithntPSZpPm8qrtSxVKtS8SCEN2Ehd3d5bZiTUmAc2iLV6wIEYEHyxYEUXxhm2p0h-zTWr_hbOz1-xMamo1D8vmzLfffN85Z89sB9SxikAFIHJRg00CjaqZYb81GxE70_H_eD_NpJkWC9Y0NbOyHMdtSjSzmUEG1PRMFbjOG9f54fa_s-uiF6sCAVsnbYsitWZB217HRE09thKEJU_aUKcc_cR1HLe_6zo7w0cDCdAiuKHpiGF_bbwb7n4-_rZ_dPAwBPaqpn9zQcf0OhJ81r1w2ihfaBGCTFrD6ybLRJiOpWW2D7tQ7KdNokczYBPVWoSnqP_adba53b211UuCqKuwKSiisDkh8SY0ECc9dPufhluPJ3msyWgjowkLAT5pIqEgAfQIhd0WLc1mDSXshPy4NKnTiQibB5uUlYAhh_fvDT_unzfZBJp2Q9LrNFiQKW4QbKxNUXzOg6fqkzMkQoUUUY1VPZBYI17Ea_UPX0Z726MX_ZPBU8HoEryJiUbFyjSCBZnRf6g8FoJ1Ha-LMnhYmm2-MuX7lnhA_eMDkabLyLZZzwiiDD9-ntQQjI0UbpWFTm9t3rJswB34jTsabEgbwPZmEb-rgpM7d48Ot0fPd1j9BX98x7S5UNnfOIslUEgiDSnZrvPeu3FeHf18OdrcmqBt0WTuJQODhdv_M_HxgMSGwXYTh6Mfl2lITLMEfTj70krOcE4kWqD_laeTXTfFSRfl38K2d5QGBRg9eHb89nBCov0jvdudmcGd6OSrsKdC5BggHowTIdFbMxER1jYJ8HvxNIoxhIxi3ElYvhAhwcTDL0kTR3sM1u0KSZExBdNrjCeIdX0WHz_OETKHpsJTMkmTwsgLkAKNHe7SLf2lwKAEFkmRpxNkgYEI-5BT2Tcif0GqgNEaqAo8gArJDY-rx3CwRfGVtlkHFUpaKAtaltelwVdlGLSgeY2VF1QaULf9_6DSAbdAZWa-oORnc0q5WMrny2WlUCplQZvFF4q52flCPlcoLswtKGyxlwW3OYcymysU5udKSrFYVkqKUur9BuDrlgE