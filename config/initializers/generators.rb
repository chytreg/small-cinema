Rails.application.config.generators do |g|
  g.test_framework :rspec
  g.orm :active_record, primary_key_type: :uuid
end
