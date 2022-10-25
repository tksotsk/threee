FactoryBot.define do
  # factory :theme1, class: Theme do
  #   first_theme { "" }
  #   second_theme { "" }
  #   third_theme { "" }
  # end
  factory :theme1, class: Theme do
    first_theme { "食事" }
    second_theme { "睡眠" }
    third_theme { "運動" }
  end
  factory :theme2, class: Theme do
    first_theme { "集中する" }
    second_theme { "落ち着く" }
    third_theme { "水分補給や食事を忘れない" }
  end
end