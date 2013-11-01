FactoryGirl.define do
  factory :user do
#    name      "My Lovecito"
#    email     "lovecito@wonderworld.com"
    sequence(:name)    { |n| "Lovecito #{n}" }
    sequence(:email)   { |n| "Lovecito_#{n}@example.com" }
    password "foobar"
    password_confirmation  "foobar"

    factory :admin do
      admin true
    end
  end
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
