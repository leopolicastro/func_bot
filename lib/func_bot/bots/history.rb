module FuncBot
  module Bots
    class History
      attr_accessor :messages

      def initialize
        @messages = []
      end

      def chronicle(role, prompt, name = nil)
        messages << Message.new(role, prompt, name)
      end

      def payload
        messages.map(&:data)
      end
    end
  end
end
