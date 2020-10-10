# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
feature_list = [
    'fa fa-tv', 'fa fa-wheelchair', 'fa fa-umbrella', 'fa fa-taxi', 'fa fa-spoon', 'fa fa-money', 'fa fa-lightbulb-o', 'fa fa-key', 'fa fa-glass', 'fa fa-camera-retro', 'fa fa-book', 'fa fa-bed', 'fa-ambulance', '', 'fa fa-credit-card', 'fa fa-medkit', 'fa fa-power-off', 'fa fa-wifi', 'fa fa-cutlery', 'fa fa-shower fa-1', 'fa fa-birthday-cake', 'fa fa-video-camera', 'fa fa-hotel', 'fa fa-map', 'fa fa-align-center', '	fa fa-align-justify', 'fa fa-align-right', 'fa fa-align-left', 'fa fa-bold', 'fa fa-chain', 'fa fa-chain-broken', 'fa fa-clipboard', 'fa fa-columns', 'fa fa-copy', 'fa fa-cut', 'fa fa-dedent', 'fa fa-eraser', 'fa fa-file', 'fa fa-file-o', 'fa fa-file-text', 'fa fa-files-o', 'fa fa-font', 'fa fa-paperclip', 'fa fa-scissors', 'fa fa-th-large', 'fa fa-plane'
]


feature_list.each do |group|
  feature = FacilityIcon.new(icon: group)
  begin
    feature.save
  rescue ActiveRecord::RecordNotUnique => e
  end

end

