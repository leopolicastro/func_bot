# frozen_string_literal: true

module FuncBot
  module Handlers
    class BaseHandler
      def dig_for_content
        response.dig("choices", 0, "message", "content")
      end
    end
  end
end
