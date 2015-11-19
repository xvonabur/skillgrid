FactoryGirl.define do

  factory :user do
    sequence(:email)        { |n| "person_#{n}@example.com" }
    password                'foobar1234'
    password_confirmation   'foobar1234'

    factory :admin, class: User do
      sequence(:name)         { |n| "Name# #{n}" }
      sequence(:last_name)    { |n| "Last name# #{n}" }
      birthday                I18n.t(20.years.ago.to_date)
      passport
      avatar
      admin                   true
      shop_owner              false
      guest                   false
    end

    factory :shop_owner, class: User do
      sequence(:shop_name)    { |n| "Pretty good shop# #{n}" }
      avatar
      admin                   false
      shop_owner              true
      guest                   false
    end

    factory :guest, class: User do
      admin                   false
      shop_owner              false
      guest                   true
    end
  end

  factory :product do
    sequence(:title)         { |n| "Super quality product# #{n}" }
    sequence(:description)   { |n| "This is the description for product# #{n}" }
    sequence(:price)         { |n| n * 1000 }
    photo
    association :user, factory: :shop_owner
  end

  factory :photo do
    image Dragonfly.app.generate(:plain, 300, 200, 'format' => 'jpeg')
  end

  factory :avatar do
    image Dragonfly.app.generate(:plain, 300, 200, 'format' => 'jpeg')
  end

  factory :passport do
    image Dragonfly.app.generate(:plain, 300, 200, 'format' => 'jpeg')
  end
end