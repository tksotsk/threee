FactoryBot.define do
  factory :project1, class: Project do
    title { "健康" }
  end

  factory :project2, class: Project do
    title { "プログラミングの学習" }
  end
end