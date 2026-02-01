# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1  = User.find_or_create_by!(email: "sato@example.com")     { |user| user.name = "佐藤 健太郎"; user.password = "password" }
user2  = User.find_or_create_by!(email: "suzuki@example.com")   { |user| user.name = "鈴木 一郎";   user.password = "password" }
user3  = User.find_or_create_by!(email: "tanaka@example.com")   { |user| user.name = "田中 美咲";   user.password = "password" }
user4  = User.find_or_create_by!(email: "takahashi@example.com") { |user| user.name = "高橋 七海";   user.password = "password" }
user5  = User.find_or_create_by!(email: "ito@example.com")      { |user| user.name = "伊藤 純一";   user.password = "password" }
user6  = User.find_or_create_by!(email: "watanabe@example.com") { |user| user.name = "渡辺 杏奈";   user.password = "password" }
user7  = User.find_or_create_by!(email: "yamamoto@example.com") { |user| user.name = "山本 裕太";   user.password = "password" }
user8  = User.find_or_create_by!(email: "nakamura@example.com") { |user| user.name = "中村 結衣";   user.password = "password" }
user9  = User.find_or_create_by!(email: "kobayashi@example.com") { |user| user.name = "小林 直樹";   user.password = "password" }
user10 = User.find_or_create_by!(email: "kato@example.com")     { |user| user.name = "加藤 恵子";   user.password = "password" }

Review.create!(user: user1, category: "フード", star: 5, title: "食いつきが最高の国産チキン", body: "色々なフードを試しましたが、これが一番美味しそうに食べます。便の状態も良くなりました。")
Review.create!(user: user1, category: "ケア用品", star: 4, title: "痛くないスリッカーブラシ", body: "今までブラッシングを嫌がっていた愛犬が、自分から寄ってくるようになりました。")

Review.create!(user: user2, category: "おもちゃ", star: 3, title: "音が鳴るアヒルのおもちゃ", body: "楽しそうに遊んでいますが、噛む力が強いので3日で笛が壊れてしまいました。")
Review.create!(user: user2, category: "おやつ", star: 5, title: "無添加の鹿肉ジャーキー", body: "ダイエット中なので、低カロリーで高タンパクなおやつを探していました。大満足です。")
Review.create!(user: user2, category: "お出かけグッズ", star: 4, title: "折りたたみ式の水飲みボウル", body: "散歩の時に持ち運びやすくて便利。カラビナ付きなのが嬉しいポイント。")

Review.create!(user: user3, category: "ケア用品", star: 2, title: "シャンプー後の速乾タオル", body: "思ったより吸水力が足りないかも。でも肌触りはとても柔らかくて良いです。")
Review.create!(user: user3, category: "おやつ", star: 5, title: "歯磨きガム(クロロフィル入り)", body: "食後の習慣にしています。口臭がかなり軽減された気がします。")

Review.create!(user: user4, category: "おもちゃ", star: 5, title: "知育玩具の定番・コング", body: "お留守番の時に中にペーストを入れて使っています。集中して遊んでくれます。")
Review.create!(user: user4, category: "お出かけグッズ", star: 3, title: "メッシュのキャリーバッグ", body: "通気性は良いのですが、底板が少し柔らかいので安定感に欠けるかな。")

Review.create!(user: user5, category: "フード", star: 4, title: "小粒で食べやすいグレインフリー", body: "アレルギー体質ですが、これに変えてから皮膚の赤みが引いてきました。")
Review.create!(user: user5, category: "おもちゃ", star: 5, title: "ロープ型の引っ張りっこ玩具", body: "毎日これで引っ張りっこしています。歯茎の刺激にもなって良さそう。")

Review.create!(user: user6, category: "ケア用品", star: 1, title: "期待外れの抜け毛取りローラー", body: "あまり毛が取れませんでした。うちの子の毛質には合わなかったようです。")
Review.create!(user: user6, category: "おやつ", star: 4, title: "フリーズドライの納豆", body: "健康のために。最初は警戒していましたが、今ではカリカリ美味しそうに食べます。")
Review.create!(user: user6, category: "お出かけグッズ", star: 5, title: "反射板付きの光る首輪", body: "夜のお散歩の必須アイテム。かなり遠くからでも目立つので安全です。")

Review.create!(user: user7, category: "おもちゃ", star: 4, title: "水に浮くフリスビー", body: "川遊びで大活躍！視認性の高いオレンジ色なのも見失わなくて良い。")
Review.create!(user: user7, category: "おやつ", star: 3, title: "大容量のササミチップス", body: "コスパは良いけど、少し硬すぎるかも。小さく割ってあげています。")

Review.create!(user: user8, category: "フード", star: 5, title: "シニア犬用の健康サポート食", body: "10歳を過ぎてから食欲が落ちていましたが、これなら完食してくれます。")
Review.create!(user: user8, category: "ケア用品", star: 4, title: "耳掃除用の低刺激クリーナー", body: "香りが優しくて、耳の中がスッキリ綺麗になります。ベタつきません。")
Review.create!(user: user8, category: "おもちゃ", star: 5, title: "噛むとひんやりするおもちゃ", body: "夏の暑い時期に重宝しました。冷蔵庫で冷やして使っています。")

Review.create!(user: user9, category: "お出かけグッズ", star: 5, title: "多機能なペットカート", body: "段差も楽々越えられます。買い物カゴも付いていて、お出かけが楽しくなりました。")
Review.create!(user: user9, category: "ケア用品", star: 2, title: "自動給水器", body: "音は静かですが、フィルターの交換頻度が高くて少し維持費がかかります。")

Review.create!(user: user10, category: "おやつ", star: 5, title: "国産ヤギミルクの粉末", body: "お水代わりに。水分補給に最適です。冬はぬるま湯で溶かしてあげています。")
Review.create!(user: user10, category: "おもちゃ", star: 4, title: "テニスボール型の投擲機", body: "広い公園で遊ぶ時に便利。遠くまで飛ぶので愛犬も大喜びで走ります。")
Review.create!(user: user10, category: "フード", star: 3, title: "トッピング用のウェットフード", body: "美味しいみたいですが、毎日あげると太りそう。特別な日用です。")
