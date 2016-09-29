FactoryGirl.define do
  factory :post do
    date Date.today
    rationale 'Some rationale.'
    user
  end
  
  factory :post_2, class: 'Post' do
    date Date.yesterday
    rationale 'Different rationale.'
    user
  end
  
  factory :post_belonging_to_other_user, class: 'Post' do
    date Date.yesterday
    rationale 'Another rationale.'
    non_authorized_user
  end
end