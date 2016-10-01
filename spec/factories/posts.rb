FactoryGirl.define do
  factory :post do
    date Date.today
    rationale 'Some rationale.'
    overtime_request 3.5
    user
  end
  
  factory :post_2, class: 'Post' do
    date Date.yesterday
    rationale 'Different rationale.'
    overtime_request 0.5
    user
  end
  
  factory :post_belonging_to_other_user, class: 'Post' do
    date Date.yesterday
    rationale 'Another rationale.'
    overtime_request 1.5
    non_authorized_user
  end
end