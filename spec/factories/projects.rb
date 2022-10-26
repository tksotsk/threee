FactoryBot.define do
  factory :project1, class: Project do
    title { "健康" }
    # public { true }
  end

  factory :project2, class: Project do
    title { "プログラミングの学習" }
    # public { true }
  end

  factory :project3, class: Project do
    title { "メモを取る" }
    # public { true }
  end

  factory :project1_true, class: Project do
    title { "健康" }
    public { true }
  end

  factory :project2_true, class: Project do
    title { "プログラミングの学習" }
    public { true }
  end

  factory :project3_true, class: Project do
    title { "メモを取る" }
    public { true }
  end
end