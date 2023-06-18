module FuncBot
  module Bots
    class Message
      attr_accessor :role, :prompt

      def initialize(role, prompt)
        @role = role
        @prompt = prompt
      end

      def data
        {role: role, content: prompt}
      end
    end
  end
end
