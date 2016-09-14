FactoryGirl.define do
  sequence :email do |n|
    "test_#{n}@example.com"  
  end
  
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email { generate :email }
    password 'asdf1234'
    password_confirmation 'asdf1234'
  end
  
  factory :admin_user, class: 'AdminUser' do
    first_name 'Admin'
    last_name 'User'
    email { generate :email }
    password 'asdf1234'
    password_confirmation 'asdf1234'
  end
end