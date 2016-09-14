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
end