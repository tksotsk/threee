FactoryBot.define do
  factory :user1, class: User do
    name { "user1" }
    email { "user1@xxx.com" }
    password { "qqqqqqqq" }
    password_confirmation { "qqqqqqqq" }
    admin {false}
  end
  
  factory :user2, class: User do
    name { "user2" }
    email { "user2@xxx.com" }
    password { "qqqqqqqq" }
    password_confirmation { "qqqqqqqq" }
    admin {false}
  end

  factory :admin, class: User do
    name { "admin" }
    email { "admin@xxx.com" }
    password { "qqqqqqqq" }
    password_confirmation { "qqqqqqqq" }
    admin {true}
  end
end