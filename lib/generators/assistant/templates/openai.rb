OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.dig(:openai, :api_key)
end
