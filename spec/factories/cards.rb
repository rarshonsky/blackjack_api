FactoryGirl.define do
  factory :card do

  end

  factory :ace, class: Card do
    suit 's'
    value '1'
    sym 'a'
  end

  factory :king, class: Card do
    suit 's'
    value '10'
    sym 'k'
  end

  factory :jack, class: Card do
    suit 's'
    value '10'
    sym 'j'
  end

  factory :seven, class: Card do
    suit 's'
    value '7'
    sym '7'
  end

end