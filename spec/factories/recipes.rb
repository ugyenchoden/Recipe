# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { 'Ema Datshi' }
    description do
      'Ema Datshi is one of the most popular and people’s beloved dish in Bhutan.
         This Bhutanese food is made up of lots of green chillies or dry chillies.
         With a huge amount of farmer cheese or local cheese made from cow milk.'
    end
    calories { 300 }
    revision { 1 }
    sequence(:entry_id) { |n| "entry#{n}" }

    after(:build) do |recipe|
      !recipe.asset && recipe.asset = build(:asset)
    end
  end
end
