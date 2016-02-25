FactoryGirl.define do

  factory :user do
    name "John Doe"
    sequence(:email) { |n| "user#{n}@oregonstate.edu" }
    password "keyboardcat"

    factory :administrator, class: User do
      is_administrator true 
    end

    factory :instructor, class: User do
    end

    factory :student, class: User do
      fte 0.25
    end
  end

  factory :preference do
  end

  factory :department do
    name "Computer Science"
    subject_code "CS"
  end

  factory :course do
    sequence(:name)          { |n| "Course #{n}" }
    sequence(:course_number) { |n| n }
    association :department
  end

  factory :section do
    current_enrollment 30
    association :course
  end

end
