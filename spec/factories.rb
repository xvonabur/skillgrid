FactoryGirl.define do

  factory :user do
    sequence(:name)         { |n| "Person #{n}" }
    sequence(:email)        { |n| "person_#{n}@example.com" }
    password                'foobar1234'
    password_confirmation   'foobar1234'

    factory :shop_owner do
      shop
    end
  end

  factory :product do
    sequence(:title)         { |n| "Super quality product# #{n}" }
    sequence(:description)   { |n| "This is the description for product# #{n}" }
    sequence(:price)         { |n| n * 1000 }
    photo
  end

  factory :shop do
    sequence(:name)          { |n| "Pretty good shop# #{n}" }
  end

  factory :photo do
    image Dragonfly.app.generate(:plain, 300, 200, 'format' => 'jpeg')
  end
end