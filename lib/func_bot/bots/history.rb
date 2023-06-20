module FuncBot
  module Bots
    class History
      attr_accessor :chronicles

      def initialize
        @chronicles = []
      end

      def chronicle(role, prompt, name = nil)
        chronicles << Message.new(role, prompt, name)
      end

      def payload
        chronicles.map(&:data)
      end
    end
  end
end
