FactoryGirl.define do
  factory :post do
    date Date.today
    rationale 'Some rationale.'
  end
  
  factory :post_2, class: 'Post' do
    date Date.yesterday
    rationale 'Different rationale.'
  end
end