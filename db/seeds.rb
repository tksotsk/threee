# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin1 = User.create({name: "管理者", email: "admin@admin.com", password: "qqqqqqqq", admin: true})
user1 = User.create({name: "鈴木一郎", email: "user1@email.com", password: "qqqqqqqq"})
user2 = User.create({name: "佐藤二郎", email: "user2@email.com", password: "qqqqqqqq"})
user3 = User.create({name: "田中三郎", email: "user3@email.com", password: "qqqqqqqq"})
user4 = User.create({name: "いとうにしよう", email: "user4@email.com", password: "qqqqqqqq"})

project1 = Project.create({title: "読書", public: true, user_id: user1.id})
project2 = Project.create({title: "プログラミング", public: true, user_id: user1.id})
project3 = Project.create({title: "メモの取り方", public: false, user_id: user1.id})
project4 = Project.create({title: "音読", public: true, user_id: user2.id})
project5 = Project.create({title: "朝の習慣", public: true, user_id: user2.id})

theme1 = Theme.create({first_theme: "集中する", second_theme: "水を飲む", third_theme: "タイプミスに気を付ける", project_id: project2.id })
theme2 = Theme.create({first_theme: "時間をはかる", second_theme: "水を飲む", third_theme: "姿勢に気を付ける", project_id: project2.id })
theme3 = Theme.create({first_theme: "時間をはかる", second_theme: "前日の夜はしっかりと寝る", third_theme: "姿勢に気を付ける", project_id: project2.id })
theme4 = Theme.create({first_theme: "時間を決めて、リラックスする", second_theme: "日記や覚え書きを書く", third_theme: "次読むものを決めておく", project_id: project1.id })
theme5 = Theme.create({first_theme: "最初のうちは殴り書きでもいいのでとにかく書く", second_theme: "回数を重ねる", third_theme: "書き終わったら数分でもよいので、まとめる時間を取る", project_id: project3.id })
theme6 = Theme.create({first_theme: "自分の好きなものを題材に選ぶ", second_theme: "時間を決めてその時間内で読めるところまで読む", third_theme: "読めない漢字はメモしておく", project_id: project4.id })
theme7 = Theme.create({first_theme: "ストレッチ", second_theme: "水を飲む", third_theme: "朝食を忘れない", project_id: project5.id })

# お気に入りを最初にオフ（解除してある状態）にしたければコメントアウトしてください
favorite1 = Favorite.create({user_id: user1.id, project_id: project4.id})
favorite2 = Favorite.create({user_id: user1.id, project_id: project5.id})
favorite3 = Favorite.create({user_id: user2.id, project_id: project2.id})
favorite4 = Favorite.create({user_id: user2.id, project_id: project3.id})
favorite5 = Favorite.create({user_id: user3.id, project_id: project2.id})
favorite6 = Favorite.create({user_id: user4.id, project_id: project2.id})