# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admins = Admin.create!(
  [
    {last_name: "さんぷる", first_name: "花子", last_name_kana: "サンプル", first_name_kana: "ハナコ", login_id: "hanako@sample", password: "admin1234", telephone_number: "08012345678"},
    {last_name: "ゲスト", first_name: "さん", last_name_kana: "ゲスト", first_name_kana: "サン", login_id: "guest@example", password: "kahagmklsaygua", telephone_number: "0120888555"}
  ]
)


User.create!(
  [
    {last_name: "ゲスト", first_name: "さん", last_name_kana: "ゲスト", first_name_kana: "サン", login_id: "guest@example", password: "kahagmklsaygua", telephone_number: "0120888555"},
  ]
)
