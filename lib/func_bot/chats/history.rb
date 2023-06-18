module FuncBot
  module Chats
    class History
      attr_accessor :history
      def initialize
        @history = []
      end

      def push_prompt(role, prompt)
        @history << {role: role, content: prompt}
      end
    end
  end
end
