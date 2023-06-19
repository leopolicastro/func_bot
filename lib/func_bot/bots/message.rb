module FuncBot
  module Bots
    class Message
      attr_accessor :role, :prompt, :name

      def initialize(role, prompt, name = nil)
        @role = role
        @prompt = prompt
        @name = name
      end

      def data
        if name.nil?
          {role: role, content: prompt}
        else
          {role: role, content: prompt, name: name}
        end
      end
    end
  end
end
