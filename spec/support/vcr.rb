# frozen_string_literal: true

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = Rails.root.join('spec/vcr')
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = {
    allow_playback_repeats: true,
    match_requests_on: %i[method uri headers],
    record: :new_episodes
  }
end
