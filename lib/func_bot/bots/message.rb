module FuncBot
  module Bots
    class Message
      attr_accessor :role, :content, :name

      def initialize(role, content, name = nil)
        @role = role
        @content = content
        @name = name
      end

      def data
        if name.nil?
          {role: role, content: content}
        else
          {role: role, content: content, name: name}
        end
      end
    end
  end
end
