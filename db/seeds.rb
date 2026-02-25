# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = {
  u1: User.create!(name: "レオパパ", email: "leo@example.com", password: "password"),
  u2: User.create!(name: "ココアmama", email: "cocoa@example.com", password: "password"),
  u3: User.create!(name: "まろぷり", email: "maropuri@example.com", password: "password"),
  u4: User.create!(name: "しばけんコタロウ", email: "kota@example.com", password: "password"),
  u5: User.create!(name: "ルナの旅日記", email: "luna@example.com", password: "password"),
  u6: User.create!(name: "フレンチベル", email: "belle@example.com", password: "password"),
  u7: User.create!(name: "アジリティ大好き", email: "agility@example.com", password: "password"),
  u8: User.create!(name: "シニア犬サポート", email: "moka@example.com", password: "password"),
  u9: User.create!(name: "パグ福", email: "pagu@example.com", password: "password"),
  u10: User.create!(name: "サクラの里", email: "sakura@example.com", password: "password")
}

# --- 2. 愛犬の作成 ---
d1 = Dog.create!(user: users[:u1], name: "レオ", breed: "ゴールデンレトリバー", birthday: "2018-04-12", gender: 0, size: 2)
d1.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog01.jpg")), filename: "dog01.jpg")

d2 = Dog.create!(user: users[:u2], name: "ココア", breed: "トイプードル", birthday: "2021-09-05", gender: 1, size: 0)
d2.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog02.jpg")), filename: "dog02.jpg")

d3 = Dog.create!(user: users[:u3], name: "マロン", breed: "チワワ", birthday: "2019-12-20", gender: 1, size: 0)
d3.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog03.jpg")), filename: "dog03.jpg")

d4 = Dog.create!(user: users[:u3], name: "プリン", breed: "チワワ", birthday: "2022-03-15", gender: 1, size: 0)
d4.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog04.jpg")), filename: "dog04.jpg")

d5 = Dog.create!(user: users[:u4], name: "コタロウ", breed: "柴犬", birthday: "2017-06-30", gender: 0, size: 1)
d5.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog05.jpg")), filename: "dog05.jpg")

d6 = Dog.create!(user: users[:u5], name: "ルナ", breed: "ポメラニアン", birthday: "2023-01-10", gender: 1, size: 0)
d6.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog06.jpg")), filename: "dog06.jpg")

d7 = Dog.create!(user: users[:u6], name: "ベル", breed: "フレンチブルドッグ", birthday: "2020-11-25", gender: 1, size: 1)
d7.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog07.jpg")), filename: "dog07.jpg")

d8 = Dog.create!(user: users[:u7], name: "カイ", breed: "ボーダーコリー", birthday: "2019-02-14", gender: 0, size: 1)
d8.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog08.jpg")), filename: "dog08.jpg")

d9 = Dog.create!(user: users[:u7], name: "ソラ", breed: "シェルティ", birthday: "2021-07-07", gender: 0, size: 1)
d9.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog09.jpg")), filename: "dog09.jpg")

d10 = Dog.create!(user: users[:u8], name: "モカ", breed: "ミニチュアダックス", birthday: "2016-08-22", gender: 1, size: 0)
d10.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog10.jpg")), filename: "dog10.jpg")

d11 = Dog.create!(user: users[:u9], name: "福", breed: "パグ", birthday: "2021-10-10", gender: 0, size: 0)
d11.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog11.jpg")), filename: "dog11.jpg")

d12 = Dog.create!(user: users[:u10], name: "サクラ", breed: "秋田犬", birthday: "2018-03-03", gender: 1, size: 2)
d12.dog_image.attach(io: File.open(Rails.root.join("app/assets/images/dog12.jpg")), filename: "dog12.jpg")

dogs = { d1: d1, d2: d2, d3: d3, d4: d4, d5: d5, d6: d6, d7: d7, d8: d8, d9: d9, d10: d10, d11: d11, d12: d12 }

review_list = [
  { user: users[:u1], dogs: [dogs[:d1]], star: 5.0, cat: "ごはん", title: "食いつきが全然違います！", body: "大型犬用のこのフードに変えてから、レオの毛並みが驚くほどツヤツヤになりました。これまでは粒が小さすぎると丸飲みしてしまって消化に悪そうだったのですが、このフードは粒が大きめでしっかり噛んで食べてくれます。原材料もヒューマングレードで安心ですし、何より毎朝のご飯の時間をレオが尻尾をちぎれんばかりに振って楽しみに待っている姿を見ると、本当に変えて良かったなと実感しています。お値段は少し張りますが、健康維持のためなら安いものです。" },
  { user: users[:u2], dogs: [dogs[:d2]], star: 3.5, cat: "おもちゃ", title: "デザインは可愛いけれど…", body: "トイプードルのココアのために購入しました。見た目は非常に可愛らしく、届いた瞬間は私の方がテンションが上がってしまいましたが、強度が少し物足りないかもしれません。ココアが夢中でカミカミしていたら、わずか1週間で端の方から綿が出てきてしまいました。小型犬用と書いてありましたが、噛む力が強い子には向かないかもしれません。ただ、ココア自身は非常に気に入っているようで、壊れた後も中身を抜いた状態で楽しそうに振り回して遊んでいます。次はもう少し丈夫な素材のものを探します。" },
  { user: users[:u3], dogs: [dogs[:d3], dogs[:d4]], star: 4.5, cat: "おやつ", title: "多頭飼いには嬉しい大容量", body: "チワワのマロンとプリンのために、こちらの無添加ジャーキーをリピートしています。二頭いるとどうしてもおやつの消費が早いのですが、こちらは大容量パックがあるので非常に助かっています。手で簡単に小さくちぎれるので、しつけの際のご褒美としても使い勝手が良いです。添加物や保存料が一切使われていないので、安心して毎日あげることができます。開封後は冷蔵庫保管をしていますが、最後の一片まで美味しそうな香りが続いており、二頭ともこの袋の音がするだけで猛ダッシュで寄ってきます。" },
  { user: users[:u9], dogs: [dogs[:d11]], star: 4.0, cat: "おもちゃ", title: "知育玩具で退屈知らず", body: "パグの福は食欲旺盛なので、早食い防止と退屈しのぎを兼ねてこの知育おもちゃを導入しました。中に小さくカットしたおやつを仕込んでおくと、鼻を上手に使って一生懸命に転がしながら取り出そうと奮闘しています。鼻ぺちゃのパグでも使いやすい設計になっていて、30分くらいは夢中で遊んでくれるので、私が家事で手が離せない時などに重宝しています。プラスチック製ですが角が丸くなっていて安全ですし、水洗いも簡単なので衛生面でも安心して使い続けることができています。" },
  { user: users[:u4], dogs: [dogs[:d5]], star: 4.5, cat: "ごはん", title: "国産の鹿肉フードに挑戦", body: "柴犬のコタロウは最近少し太り気味だったので、低脂肪な鹿肉ベースのごはんに切り替えてみました。袋を開けた瞬間からお肉の香ばしい匂いが漂い、偏食気味なコタロウも目を輝かせて待っています。切り替えて1ヶ月ほど経ちますが、体重が少しずつ適正に戻り始め、心なしか散歩中の足取りも軽くなったように感じます。粒は平べったい形状で、噛む力が強い柴犬にはちょうど良い歯応えのようです。国産で無添加という点も、毎日の健康を考えると非常にポイントが高いです。" },
  { user: users[:u6], dogs: [dogs[:d7]], star: 5.0, cat: "ごはん", title: "フレブル特有の悩みが解消", body: "ベルのようなフレンチブルドッグは皮膚がデリケートで、これまでは季節の変わり目になると体を痒がることが多くて可哀想でした。専門家の方に相談して、アレルゲンをカットしたこのごはんを試したところ、あんなに悩んでいた赤みがスッと引いて、今では綺麗な肌をキープできています。便の匂いも以前より抑えられている気がしますし、何より美味しそうに完食してくれる姿が見れるのが一番の喜びです。同じ悩みを持つフレブルのオーナーさんには、ぜひ一度試してみてほしいです。" },
  { user: users[:u5], dogs: [dogs[:d6]], star: 4.0, cat: "おやつ", title: "ご褒美に最適なフリーズドライ", body: "ポメラニアンのルナは非常にグルメで、普通のおやつにはすぐに飽きてしまうのですが、このフリーズドライの納豆と豆腐は別格のようです。素材そのものの味が凝縮されているからか、トレーニングの時の集中力が格段に上がりました。一粒が非常に軽くて小さいので、体重管理をしている小型犬でも罪悪感なく多めにあげられるのが嬉しいポイントです。保存料も一切入っていないので安心して与えられますし、サクサクとした食感もルナのお気に入りのようです。持ち運びも軽くて便利です。" },
  { user: users[:u10], dogs: [dogs[:d12]], star: 5.0, cat: "おやつ", title: "秋田犬も満足の牛皮ガム", body: "大型犬のサクラにとって、市販のガムは一瞬で食べ終わってしまうのが悩みでしたが、この特大サイズの牛皮ガムはさすがの耐久性です。しっかりとした厚みがあり、サクラが前足で器用に押さえながら30分以上かけてじっくりと噛み続けてくれます。デンタルケアとしても非常に優秀で、これを習慣にしてから歯石がつきにくくなったように感じます。ストレス解消にもなっているようで、噛み終わった後はいつも満足そうな顔で眠りについています。大型犬を飼っている方には自信を持っておすすめできる一品です。" },
  { user: users[:u7], dogs: [dogs[:d8], dogs[:d9]], star: 4.5, cat: "おもちゃ", title: "アジリティ練習用のディスク", body: "ボーダーコリーのカイとシェルティのソラと一緒に遊ぶために購入しました。これまでのプラスチック製はキャッチした時に口を傷つけないか心配でしたが、この素材は適度な柔らかさと弾力があり、非常に安全性が高いと感じます。飛行姿勢が安定しているので、初心者である私のような飼い主が投げても綺麗に飛んでくれます。カイは空中キャッチに夢中で、毎日これを持ち出しては散歩に連れて行けと催促してきます。二頭で引っ張り合いをしても破れないほど丈夫なので、非常にコスパの良い投資でした。" },
  { user: users[:u8], dogs: [dogs[:d10]], star: 3.5, cat: "おもちゃ", title: "シニア犬でも遊べる柔らかボール", body: "ダックスのモカは10歳を過ぎてから、硬いおもちゃをあまり好まなくなりました。そこでこのラテックス製の柔らかいボールをプレゼントしたところ、久しぶりに元気に追いかける姿を見せてくれました。中に笛が入っていて、軽い力で押すだけで優しい音が鳴るので、顎の力が弱まってきたシニア犬でも十分に楽しめます。バウンドが予測できない動きをするので、短時間の遊びでも良い刺激になっているようです。ただ、表面の塗装が剥がれやすいので、遊んでいる時は誤飲しないよう見守りが必要です。" }
]

created_reviews = []
review_list.each do |data|
  r = Review.create!(
    user: data[:user],
    title: data[:title],
    body: data[:body],
    star: data[:star],
    category: data[:cat]
  )
  data[:dogs].each do |dog|
    DogReview.create!(dog: dog, review: r)
  end
  created_reviews << r
end

comments_data = [
  { user: users[:u2], r_idx: 0, text: "レオくんの毛並み、本当に綺麗ですよね！画像越しでもツヤが伝わってきます。うちのココアも最近フードの食いつきが悪いので、同じブランドの小型犬用を検討してみようと思います。" },
  { user: users[:u10], r_idx: 0, text: "秋田犬のサクラも大型犬用を食べていますが、粒の大きさは大事ですよね。しっかり噛んでくれると安心感があります。" },
  { user: users[:u1], r_idx: 1, text: "ココアちゃん可愛いのに壊しちゃうんですね（笑）大型犬用のレオも同じタイプのおもちゃは秒殺でした。最近は硬めのラテックス製が一番長持ちしていますよ！" },
  { user: users[:u5], r_idx: 1, text: "うちはポメラニアンですが、やっぱり綿が出ちゃうことあります。見た目が可愛いとつい買っちゃうんですけどね。" },
  { user: users[:u4], r_idx: 2, text: "多頭飼いだとおやつ代もバカになりませんよね。無添加で大容量なのは魅力的です。うちもチェックしてみます！" },
  { user: users[:u9], r_idx: 2, text: "マロンちゃんとプリンちゃん、袋の音でダッシュしてくるの想像して笑っちゃいました。可愛いですね！" },
  { user: users[:u8], r_idx: 3, text: "福くんの鼻ぺちゃ顔が一生懸命探す姿、想像して癒やされました。鼻ぺちゃでも使いやすい設計なのは嬉しい情報です。" },
  { user: users[:u1], r_idx: 4, text: "鹿肉はヘルシーでいいですよね。コタロウくんの足取りが軽くなったとのこと、ダイエット成功おめでとうございます！" },
  { user: users[:u7], r_idx: 4, text: "うちのボーダーコリーも鹿肉大好きです。やっぱり野生の血が騒ぐんでしょうか（笑）" },
  { user: users[:u3], r_idx: 5, text: "ベルちゃん、肌の赤みが引いて本当によかったです！皮膚の悩みは見ていて辛いですもんね。良い情報ありがとうございます。" },
  { user: users[:u6], r_idx: 5, text: "フレブルオーナーとして、このレビューは非常に助かります。早速調べてみます！" },
  { user: users[:u2], r_idx: 6, text: "納豆のフリーズドライ！匂いとかは気になりますか？ココアにも健康のために発酵食品をあげてみたいです。" },
  { user: users[:u5], r_idx: 6, text: "ルナちゃん、グルメですね（笑）持ち運びが便利なら旅行用のご褒美にも良さそう！" },
  { user: users[:u1], r_idx: 7, text: "秋田犬でも30分持つのは凄いですね！レオなら10分で終わりそうですが、大型犬には貴重なアイテムです。" },
  { user: users[:u10], r_idx: 7, text: "サクラが満足そうに眠る姿を見るのが、飼い主としても一番の幸せです。" },
  { user: users[:u4], r_idx: 8, text: "カイくんとソラくん、二頭で遊んでいる姿が目に浮かびます。安全性も高いディスクなら安心して練習できますね。" },
  { user: users[:u7], r_idx: 8, text: "ディスク練習、コツがあれば今度教えてください！なかなか真っ直ぐ飛ばなくて苦戦しています。" },
  { user: users[:u8], r_idx: 9, text: "モカちゃん、久しぶりに元気に遊べてよかったですね！シニアになるとおもちゃ選びも慎重になりますよね。" },
  { user: users[:u3], r_idx: 9, text: "ラテックス製は音も優しいから、シニア犬の耳にも刺激が強すぎなくていいかもしれませんね。" },
  { user: users[:u5], r_idx: 9, text: "塗装の剥がれについての注意点、参考になります。気をつけながらうちの子にも試してみます！" },
  { user: users[:u2], r_idx: 9, text: "シニアになっても好奇心旺盛な姿は、見ていて元気をもらえますよね。モカちゃん応援してます！" }
]

comments_data.each do |c|
  ReviewComment.create!(
    user: c[:user],
    review: created_reviews[c[:r_idx]],
    comment: c[:text]
  )
end

# レビューへのいいね
50.times do
  r = created_reviews.sample
  u = users.values.sample
  unless FavoriteReview.exists?(user: u, review: r)
    FavoriteReview.create!(user: u, review: r)
  end
end

# コメントへのいいね
50.times do
  c = ReviewComment.all.sample
  u = users.values.sample
  unless FavoriteComment.exists?(user: u, review_comment: c)
    FavoriteComment.create!(user: u, review_comment: c)
  end
end
