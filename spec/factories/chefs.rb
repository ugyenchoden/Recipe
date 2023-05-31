# frozen_string_literal: true

FactoryBot.define do
  factory :chef do
    name { 'Ugyen Choden' }
    revision { 1 }
    sequence(:entry_id) { |n| "entry#{n}" }
  end
end
