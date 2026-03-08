# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genres = {
  g1: Genre.find_or_create_by!(name: "おもちゃ"),
  g2: Genre.find_or_create_by!(name: "フード"),
  g3: Genre.find_or_create_by!(name: "おやつ"),
  g4: Genre.find_or_create_by!(name: "お出かけグッズ"),
  g5: Genre.find_or_create_by!(name: "ケア用品"),
  g6: Genre.find_or_create_by!(name: "ウェア")
}

users = {}
user_master = [
  { name: "レオパパ", email: "leo@example.com", password: "password" },
  { name: "ココアmama", email: "cocoa@example.com", password: "password" },
  { name: "まろぷり", email: "maropuri@example.com", password: "password" },
  { name: "しばけんコタロウ", email: "kota@example.com", password: "password" },
  { name: "ルナの旅日記", email: "luna@example.com", password: "password" },
  { name: "フレンチベル", email: "belle@example.com", password: "password" },
  { name: "アジリティ大好き", email: "agility@example.com", password: "password" },
  { name: "シニア犬サポート", email: "moka@example.com", password: "password" },
  { name: "パグ福", email: "pagu@example.com", password: "password" },
  { name: "サクラの里", email: "sakura@example.com", password: "password" },
  { name: "test", email: "123@123.jp", password: "123123" },
  { name: "test2", email: "demouser@demouser.jp", password: "123123" }
]

puts "Checking and creating users..."

user_master.each_with_index do |u, i|
  user = User.find_or_create_by!(email: u[:email]) do |new_user|
    new_user.name = u[:name]
    new_user.password = u[:password]
  end
  
  users["u#{i+1}".to_sym] = user
end

puts "Users processed: #{User.count} users in database."


dogs = {}
dog_data = [
  { u: :u1, n: "レオ", b: "ゴールデンレトリバー", bd: "2018-04-12", g: 0, s: 2, img: "dog01.jpg" },
  { u: :u2, n: "ココア", b: "トイプードル", bd: "2021-09-05", g: 1, s: 0, img: "dog02.jpg" },
  { u: :u3, n: "マロン", b: "チワワ", bd: "2019-12-20", g: 1, s: 0, img: "dog03.jpg" },
  { u: :u3, n: "プリン", b: "チワワ", bd: "2022-03-15", g: 1, s: 0, img: "dog04.jpg" },
  { u: :u4, n: "コタロウ", b: "柴犬", bd: "2017-06-30", g: 0, s: 1, img: "dog05.jpg" },
  { u: :u5, n: "ルナ", b: "ポメラニアン", bd: "2023-01-10", g: 1, s: 0, img: "dog06.jpg" },
  { u: :u6, n: "ベル", b: "フレンチブルドッグ", bd: "2020-11-25", g: 1, s: 1, img: "dog07.jpg" },
  { u: :u7, n: "カイ", b: "ボーダーコリー", bd: "2019-02-14", g: 0, s: 1, img: "dog08.jpg" },
  { u: :u7, n: "ソラ", b: "シェルティ", bd: "2021-07-07", g: 0, s: 1, img: "dog09.jpg" },
  { u: :u8, n: "モカ", b: "ミニチュアダックス", bd: "2016-08-22", g: 1, s: 0, img: "dog10.jpg" },
  { u: :u9, n: "福", b: "パグ", bd: "2021-10-10", g: 0, s: 0, img: "dog11.jpg" },
  { u: :u10, n: "サクラ", b: "秋田犬", bd: "2018-03-03", g: 1, s: 2, img: "dog12.jpg" }
]

puts "Checking and creating dogs..."

dog_data.each_with_index do |d, i|
  dog = Dog.find_or_create_by!(name: d[:n], user: users[d[:u]]) do |new_dog|
    new_dog.breed = d[:b]
    new_dog.birthday = d[:bd]
    new_dog.gender = d[:g]
    new_dog.size = d[:s]
  end
  
  unless dog.dog_image.attached?
    path = Rails.root.join("app/assets/images/#{d[:img]}")
    if File.exist?(path)
      dog.dog_image.attach(io: File.open(path), filename: d[:img])
    else
      puts "Warning: Image not found at #{path}"
    end
  end
  
  dogs["d#{i+1}".to_sym] = dog
end

puts "Dogs processed: #{Dog.count} dogs in database."

review_list = [
  { user: users[:u1], dogs: [dogs[:d1]], genre: genres[:g2], item: "ロイヤルカナン 大型犬専用フード", star: 5.0, cat: "プレミアム", title: "食いつきが全然違います！", body: "大型犬用のこのフードに変えてから、レオの毛並みが驚くほどツヤツヤになりました。以前は食後に少しお腹を壊しやすかったのですが、これにしてからは便の状態も非常に安定しています。粒の大きさも大型犬がしっかり噛めるサイズ感で、毎日の食事が楽しみなようです。少し価格は張りますが、愛犬の健康を考えると、これからも継続して購入したいと思える納得のクオリティです。" },
  { user: users[:u2], dogs: [dogs[:d2]], genre: genres[:g1], item: "ふわふわぬいぐるみボーン", star: 3.5, cat: "音が出る", title: "デザインは可愛いけれど…", body: "トイプードルのココアのために購入しました。見た目の可愛さと、噛むとピコピコ鳴る音に最初は夢中で遊んでいましたが、生地が少し薄いのか、数日で角の部分から中綿が出てきてしまいました。小型犬用とはいえ、噛む力が強い子だと少し耐久性に不安があるかもしれません。お留守番の時というよりは、飼い主と一緒に目が届く範囲で遊ばせる分には、コミュニケーションツールとして非常に優秀だと思います。" },
  { user: users[:u3], dogs: [dogs[:d3], dogs[:d4]], genre: genres[:g3], item: "極上ささみジャーキー大容量", star: 4.5, cat: "無添加", title: "多頭飼いには嬉しい大容量", body: "チワワのマロンとプリンのために購入。無添加・国産という点に惹かれましたが、開けた瞬間に人間でも美味しそうと感じるほど香りが良いです。市販のものは保存料が気になるので、こうした安心できるおやつは重宝しますね。大容量パックなので、二匹に毎日少しずつあげても一ヶ月近く持ちますし、ジッパー付きの袋で鮮度が保てるのもポイントが高いです。しつけのご褒美として小さくちぎってあげやすい硬さなのも助かります。" },
  { user: users[:u9], dogs: [dogs[:d11]], genre: genres[:g1], item: "知育トイ・トリートボール", star: 4.0, cat: "室内遊び", title: "知育玩具で退屈知らず", body: "パグの福は食欲旺盛なので、早食い防止と退屈しのぎを兼ねて購入しました。ボールの中に小粒のフードを入れると、鼻を使って一生懸命転がしながら遊んでいます。最初はコツを掴むまで時間がかかっていましたが、一度覚えると夢中で追いかけています。雨の日でお散歩に行けない時のストレス発散に最適ですね。丸洗いが可能なので、ヨダレやフードのカスで汚れても清潔に保てるのが非常に衛生的で気に入っています。" },
  { user: users[:u4], dogs: [dogs[:d5]], genre: genres[:g2], item: "野生鹿肉ドッグフード 2kg", star: 4.5, cat: "ダイエット", title: "国産の鹿肉フードに挑戦", body: "柴犬のコタロウは最近少し太り気味だったので、低カロリーで高タンパクな鹿肉フードに切り替えました。独特の匂いがあるかと思いましたが、意外とあっさりしていて食べやすいようです。一ヶ月ほど続けてみたところ、体重が少しずつ落ちてきて、以前よりも元気に走り回るようになりました。アレルギーが出にくいと言われる鹿肉なので、皮膚の弱い柴犬には向いているのかもしれません。チャック付きで保存も楽です。" },
  { user: users[:u6], dogs: [dogs[:d7]], genre: genres[:g2], item: "アレルゲンカット・サーモン主原料", star: 5.0, cat: "皮膚ケア", title: "フレブル特有の悩みが解消", body: "ベルのようなフレンチブルドッグは皮膚がデリケートで、食事には非常に気を遣います。このサーモン主原料のフードに変えてから、首回りの赤みが引き、体を痒がる仕草が目に見えて減りました。穀物フリーなのも安心材料の一つです。サーモンの香りが強いので食いつきも良く、毎食完食してくれます。フレブルの体質に合ったフードを探すのは大変でしたが、ようやく理想的なものに出会えた気がします。" },
  { user: users[:u5], dogs: [dogs[:d6]], genre: genres[:g3], item: "フリーズドライ納豆&豆腐", star: 4.0, cat: "しつけ用", title: "ご褒美に最適なフリーズドライ", body: "ポメラニアンのルナは非常にグルメで好き嫌いが激しいのですが、この納豆と豆腐のフリーズドライは大好物です。サクサクとした食感が楽しいのか、おねだりする時の目が違いますね。納豆のネバネバ感はないので、ルナの長い胸毛が汚れる心配もなく、外出先でのご褒美としても非常に使い勝手が良いです。植物性タンパク質を手軽に摂取できるので、健康維持のためにもこれからもおやつとして取り入れたいと思います。" },
  { user: users[:u10], dogs: [dogs[:d12]], genre: genres[:g3], item: "特大牛皮ガム（ハードタイプ）", star: 5.0, cat: "長持ち", title: "秋田犬も満足の牛皮ガム", body: "大型犬のサクラにとって、市販のガムは数分で食べ終えてしまうのですが、このハードタイプは一時間近く格闘しています。顎の力が強い秋田犬でも、これだけの厚みと硬さがあれば満足感があるようです。デンタルケアとしての効果も期待でき、奥歯に付いていた汚れが少しずつ落ちてきたように感じます。天然素材のみで作られているため、長時間噛んでいても胃腸に負担がかかりにくい点も、大型犬オーナーとしては非常に安心できるポイントです。" },
  { user: users[:u7], dogs: [dogs[:d8], dogs[:d9]], genre: genres[:g1], item: "ソフトディスク・プロ", star: 4.5, cat: "スポーツ", title: "アジリティ練習用のディスク", body: "ボーダーコリーのカイとシェルティのソラと一緒に、広場でディスクキャッチの練習をしています。プラスチック製だとキャッチの際に歯を傷めないか心配でしたが、このソフトタイプは柔軟性があり、愛犬の口に優しい設計になっています。それでいて飛行性能も高く、風に乗って綺麗に飛んでくれるので、初心者でも扱いやすいです。オレンジ色の目立つカラーにしたので、草むらに落ちてもすぐに見つけられるのも助かっています。" },
  { user: users[:u8], dogs: [dogs[:d10]], genre: genres[:g1], item: "ラテックス製プピプピボール", star: 3.5, cat: "シニア向け", title: "シニア犬でも遊べる柔らかボール", body: "ダックスのモカは10歳を過ぎてから、硬いおもちゃを敬遠するようになりましたが、このラテックス製のボールは柔らかくて噛み心地が良いようです。軽く噛むだけで音が鳴るので、耳が少し遠くなってきたモカでも音に反応して楽しそうに遊んでいます。サイズ感もダックスの小さな口にぴったりで、転がして持ってこさせる運動は、足腰の筋肉維持にも一役買っています。シニア犬でも無理なく遊べるおもちゃがあるのは嬉しいですね。" },
  { user: users[:u1], dogs: [dogs[:d1]], genre: genres[:g6], item: "大型犬用クールメッシュウェア", star: 4.0, cat: "夏対策", title: "夏の散歩もこれで安心", body: "ゴールデンレトリバーのレオは暑さに弱く、夏の散歩は毎年苦労していました。このクールウェアは水に濡らして軽く絞ってから着せると、気化熱でレオの体温を適度に下げてくれます。メッシュ素材なので通気性も良く、濡らしても重くならないのが良いですね。デザインもスポーティーでかっこよく、周りの犬仲間からも『涼しそうだね』と声をかけられます。夏の猛暑日でも、これがあればレオと一緒に少し長く外を歩けるようになりました。" },
  { user: users[:u2], dogs: [dogs[:d2]], genre: genres[:g5], item: "低刺激パウケアクリーム", star: 4.5, cat: "肉球ケア", title: "ぷにぷにの肉球が戻りました", body: "トイプードルのココアは散歩が大好きですが、冬場の乾燥で肉球がカサカサになり、ひび割れしそうになっていました。このクリームは非常に伸びが良く、ベタつかないので塗った後に室内を歩いても床が汚れません。ラベンダーの優しい香りで、リラックス効果もあるようです。数日間お風呂上がりにマッサージしながら塗ってあげたところ、パピーの頃のようなぷにぷにの柔らかさが戻ってきました。舐めても無害な天然成分なのが何より安心です。" },
  { user: users[:u4], dogs: [dogs[:d5]], genre: genres[:g5], item: "抜け毛ごっそりブラシ", star: 5.0, cat: "ブラッシング", title: "換毛期の救世主です", body: "柴犬のコタロウの抜け毛は凄まじく、掃除機をかけても追いつかないほどでしたが、このブラシを使い始めてから家の中の毛が激減しました。不要なアンダーコートだけを驚くほど効率よく取り除いてくれます。最初は痛がらないか心配でしたが、コタロウ自身もブラッシング中にうっとりした表情をしていて、マッサージ効果もあるようです。これ一回でスーパーの袋がいっぱいになるほど毛が取れるので、毎日のブラッシングが飼い主にとっても楽しみになりました。" },
  { user: users[:u5], dogs: [dogs[:d6]], genre: genres[:g4], item: "軽量ペットカート・コンパクト", star: 4.5, cat: "お出かけ", title: "電車移動が楽になりました", body: "3kgのポメラニアン、ルナとの電車移動のために購入しました。これまではキャリーバッグで肩が凝っていましたが、このカートは非常に軽量で操作性が良く、人混みでもスムーズに移動できます。折りたたみがワンタッチで簡単なので、駅の階段やバスへの乗降も一人でこなせます。メッシュの窓が大きく、ルナも外の景色を眺めながら安心して乗っています。下部のバスケットに荷物も入れられるので、週末のドッグカフェ巡りがさらに楽しくなりました。" },
  { user: users[:u3], dogs: [dogs[:d3]], genre: genres[:g5], item: "涙やけクリーンウォーター", star: 3.0, cat: "目元ケア", title: "地道に継続中", body: "チワワのマロンは白い毛の部分が多いので、涙やけによる茶色いシミが目立っていました。このクリーンウォーターをコットンに含ませて、毎日優しく拭き取っています。即効性があるわけではありませんが、一ヶ月ほど続けた結果、新しく生えてくる毛には汚れがつきにくくなったように感じます。アルコール不使用で目に染みる心配がないため、マロンも嫌がらずに拭かせてくれます。真っ白な目元を目指して、これからも根気強く続けていきたいと思います。" },
  { user: users[:u7], dogs: [dogs[:d8]], genre: genres[:g2], item: "ハイプロテイン・エナジー", star: 5.0, cat: "高栄養", title: "運動量の多い子にぴったり", body: "アジリティ競技をしているボーダーコリーのカイには、高タンパクで高エネルギーなこのフードが欠かせません。以前のフードに比べて筋肉の質が引き締まり、持久力が向上したように感じます。競技会当日の集中力も上がり、最後までスピードを落とさずにコースを走り抜けるようになりました。消化吸収も良いようで、ハードな運動の後でも便の状態が変わらず安定しているのも、体調管理をする上で非常に心強いポイントです。アスリート犬には最適ですね。" },
  { user: users[:u9], dogs: [dogs[:d11]], genre: genres[:g4], item: "フレブル・パグ専用ハーネス", star: 4.5, cat: "散歩", title: "気管を圧迫しない設計", body: "パグの福は興奮すると散歩中にゼーゼーと苦しそうな声を出すことがありましたが、この専用ハーネスに変えてから呼吸がとても楽そうです。短頭種の骨格に合わせた設計になっているため、首への負担が少なく、体全体でしっかりサポートしてくれます。バックルが背中側にあるので着脱も非常にスムーズで、洋服の上からでもサイズ調整がしやすいです。パグらしいユニークな体型にもしっかりフィットして、お散歩中の抜け出しも防止できる安心の設計です。" },
  { user: users[:u10], dogs: [dogs[:d12]], genre: genres[:g1], item: "超大型ロープ・トイ", star: 4.0, cat: "頑丈", title: "引っ張りっこが楽しい", body: "秋田犬のサクラと全力で遊ぶために購入しました。一般的なおもちゃだとすぐに噛み切られてしまいますが、このロープは非常に太くて編み込みが頑丈なので、数ヶ月経っても形を保っています。サクラが思い切り引っ張っても千切れる気配がなく、飼い主も一緒に体重をかけて踏ん張れるサイズ感が素晴らしいです。ただ、ロープ自体がかなり重いので、振り回して足に当たるとそれなりに痛いです（笑）。大型犬ならではの豪快な遊びを支えてくれる、頼もしいアイテムです。" },
  { user: users[:u8], dogs: [dogs[:d10]], genre: genres[:g3], item: "ふりかけ・ヤギミルクパウダー", star: 5.0, cat: "食欲増進", title: "食欲が落ちた時に最高", body: "10歳を過ぎたミニチュアダックスのモカは、夏場や体調によって急に食欲が落ちることがあります。そんな時にこのヤギミルクパウダーをぬるま湯で溶いてフードにかけると、驚くほど喜んで完食してくれます。牛ミルクよりも消化が良く、シニア犬の胃腸にも優しいと聞いて安心して与えています。栄養価も高く、食が細くなったシニア期の水分補給や栄養補完にはこれ以上ない助け舟です。一袋常備しておくだけで、食べない時の不安が解消されました。" },
  { user: users[:u6], dogs: [dogs[:d7]], genre: genres[:g5], item: "除菌・消臭ミスト", star: 4.0, cat: "衛生", title: "家の中の匂いが気にならない", body: "フレンチブルドッグのベルのトイレ周りや、お気に入りのベッドの消臭に使っています。市販の芳香剤のような強い香りで誤魔化すのではなく、ニオイの元からしっかり分解してくれる感覚があります。無香料なので、嗅覚が鋭いワンちゃん自身も嫌がらずに過ごせるのが良いですね。除菌効果もあるので、外から帰ってきた時のおもちゃの清拭など、家中の衛生管理に幅広く活用しています。舐めても大丈夫な成分で作られているため、ベルが顔を近づけても安心です。" }
]

puts "Creating reviews in batches (with duplication check)..."

created_reviews = []

review_list.each_slice(5) do |batch|
  batch.each do |data|
    r = Review.find_or_create_by!(title: data[:title], user: data[:user]) do |review|
      review.genre = data[:genre]
      review.item_name = data[:item]
      review.body = data[:body]
      review.star = data[:star]
      review.category = data[:cat]
    end

    data[:dogs].each do |dog|
      DogReview.find_or_create_by!(dog: dog, review: r)
    end

    created_reviews << r
  end
  
  puts "Finished a batch. Resting a moment..."
  sleep 0.5
end

puts "Review processing complete: #{Review.count} reviews in database."

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
  { user: users[:u2], r_idx: 9, text: "シニアになっても好奇心旺盛な姿は、見ていて元気をもらえますよね。モカちゃん応援してます！" },
  { user: users[:u7], r_idx: 10, text: "クールウェア、大型犬には必須ですよね。水に濡らすタイプ、持続時間はどのくらいですか？" },
  { user: users[:u10], r_idx: 11, text: "ココアちゃんの肉球ぷにぷに、羨ましいです！サクラの大きな足にも塗りやすそうなら試してみたいです。" },
  { user: users[:u1], r_idx: 12, text: "柴犬の抜け毛は本当に伝説級ですよね（笑）マッサージ効果もあるなら、レオにも良さそうです！" },
  { user: users[:u2], r_idx: 13, text: "ペットカートがあると、行ける場所が広がって楽しいですよね。折りたたみが楽なのは重要ポイントですね！" },
  { user: users[:u5], r_idx: 14, text: "マロンくん、少しずつ綺麗になっているとのこと。諦めずに継続するのが一番の近道ですね、頑張ってください！" },
  { user: users[:u6], r_idx: 15, text: "アスリート犬のカイくん、カッコいい！高タンパクな食事で、ますますキレのある動きになりそうですね。" },
  { user: users[:u4], r_idx: 16, text: "パグ・フレブル専用設計って珍しいですね！福くんが快適にお散歩できているようで何よりです。" },
  { user: users[:u3], r_idx: 17, text: "飼い主さんが筋肉痛になるほど（笑）サクラちゃんのパワーが伝わってきます。頑丈なおもちゃは助かりますね。" },
  { user: users[:u2], r_idx: 18, text: "モカちゃん、ヤギミルクで食欲戻ってよかったです！シニア期は食べない時が一番心配ですもんね。" },
  { user: users[:u9], r_idx: 19, text: "無香料の消臭剤、鼻が良いワンちゃんには一番ですね。ベルちゃんの周りが快適になって良かったです！" }
]

puts "Creating review comments in batches..."

comments_data.each_slice(5) do |batch|
  batch.each do |c|
    target_review = created_reviews[c[:r_idx]]
    
    if target_review
      ReviewComment.find_or_create_by!(
        user: c[:user],
        review: target_review,
        comment: c[:text]
      )
    end
  end
  
  puts "Processed a batch of comments. Resting..."
  sleep 0.5
end

puts "Success: All #{ReviewComment.count} comments are ready!"

# レビューへのいいね
70.times do
  r = created_reviews.sample
  u = users.values.sample
  unless FavoriteReview.exists?(user: u, review: r)
    FavoriteReview.create!(user: u, review: r)
  end
end

# コメントへのいいね
70.times do
  c = ReviewComment.all.sample
  u = users.values.sample
  unless FavoriteComment.exists?(user: u, review_comment: c)
    FavoriteComment.create!(user: u, review_comment: c)
  end
end
