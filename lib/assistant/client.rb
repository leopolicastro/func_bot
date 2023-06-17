module Assistant
  class Client
    def self.call(messages)
      client.chat(
        parameters: {
          model: "gpt-3.5-turbo-0613",
          messages: messages,
          temperature: 0.7,
          functions: Assistant::Functions::List.call
        }
      )
    end

    def self.client
      @client ||= OpenAI::Client.new
    end
  end
end
