module FuncBot
  module Bots
    class History
      attr_accessor :messages

      def initialize
        @messages = []
      end

      def chronicle(role, prompt)
        messages << Message.new(role, prompt)
      end

      def payload
        messages.map(&:data)
      end
    end
  end
end
