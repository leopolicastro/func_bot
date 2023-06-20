module FuncBot
  module Bots
    class History
      attr_accessor :messages
      def initialize
        @messages = []
      end

      def push_prompt(role, prompt)
        messages << Message.new(role, prompt).data
      end
    end
  end
end
