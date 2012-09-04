FactoryGirl.define do
  factory :document do
    sequence(:title)         { |n| "text_#{ n }" }
    sequence(:original_file) { |n| "text_#{ n }" }
  end
end

