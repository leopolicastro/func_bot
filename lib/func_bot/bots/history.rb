module FuncBot
  module Bots
    class History
      attr_accessor :history
      def initialize
        @history = []
      end

      def push_prompt(role, prompt)
        @history << Message.new(role, prompt).data
      end
    end
  end
end
