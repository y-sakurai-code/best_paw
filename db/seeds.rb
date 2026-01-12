# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.password = "password"
  user.name = "Olivia"
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.password = "password"
  user.name = "James"
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.password = "password"
  user.name = "Lucas"
end

Review.find_or_create_by!(title: "わんわんおやつ") do |review|
  review.body = "小粒でベタつかないので散歩中のご褒美に重宝しています。これを使い始めてから、苦手だった『待て』が完璧にできるようになりました！"
  review.user = olivia
end

Review.find_or_create_by!(title: "わんわんおもちゃ") do |review|
  review.body = "噛むと音が鳴るのが楽しいようで、一日中夢中で遊んでいます。丈夫な素材なので、噛む力が強い我が家の愛犬でも壊れず長持ちです。"
  review.user = james
end

Review.find_or_create_by!(title: "わんわんふーど") do |review|
  review.body = "粒の大きさがちょうど良く、食べやすそうに完食してくれます。毛並みに艶が出てきた気がしますし、無添加なので毎日安心して与えられます。"
  review.user = lucas
end