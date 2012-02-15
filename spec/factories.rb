FactoryGirl.define do
  factory :user do |f|
    f.sequence(:email) {|n| "foo#{n}@example.com"}
    f.sequence(:username) {|n| "foo#{n}"}
    f.password "secret123"
    f.roles {|r| [r.association(:internal_role)]}
  end

  factory :admin_user, class: User do |f|
    f.sequence(:email) {|n| "foo#{n}@example.com"}
    f.sequence(:username) {|n| "foo#{n}"}
    f.password "secret123"
    f.roles {|r| [r.association(:internal_role), r.association(:admin_role)]}
  end

  factory :internal_role, class: Role do |f|
    f.name "internal"
  end
  factory :admin_role, class: Role do |f|
    f.name "admin"
  end

  factory :account do
    name "TestAccount"
  end

  factory :room do
    name "Bunkersen"
  end
end
