FactoryGirl.define do
  factory :card do

  end

  factory :ace, class: Card do
    suit 'S'
    value '1'
    sym 'a'
  end

  factory :jack, class: Card do
    suit 'S'
    value '10'
    sym 'j'
  end

  factory :seven, class: Card do
    suit 'S'
    value '7'
    sym '7'
  end
end