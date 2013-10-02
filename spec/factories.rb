FactoryGirl.define do
  factory :user do
    name      "My Lovecito"
    email     "lovecito@wonderworld.com"
    password  "foobar"
    password_confirmation  "foobar"
  end
end
