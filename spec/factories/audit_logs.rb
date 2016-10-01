FactoryGirl.define do
  factory :audit_log do
    user nil
    status 1
    start_date "2016-10-01"
    end_date "2016-10-01"
  end
end
