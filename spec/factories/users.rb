FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email 'test@example.com'
    password 'asdf1234'
    password_confirmation 'asdf1234'
  end
  
  factory :admin_user, class: 'AdminUser' do
    first_name 'Justin'
    last_name 'Joseph'
    email 'justin@example.com'
    password 'asdf1234'
    password_confirmation 'asdf1234'
  end
end