# frozen_string_literal: true

FactoryBot.define do
  factory :asset do
    title { 'Ema datshi' }
    filename { 'ema_datshi.jpeg' }
    file_url { 'https://loremflickr.com/300/300' }
    revision { 1 }
    sequence(:entry_id) { |n| "entry#{n}" }
  end
end
