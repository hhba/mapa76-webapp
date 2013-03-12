FactoryGirl.define do
  factory :document do
    sequence(:title)             { |n| "text_#{ n }" }
    sequence(:original_filename) { |n| "text_#{ n }" }

    file { StringIO.new("empty content") }

    trait :published do
      public true
    end
  end
end

5.times { FactoryGirl.create :document, :published }
