# frozen_string_literal: true

module FuncBot
  module Handlers
    class BotHandler < BaseHandler
      attr_accessor :response, :bot

      def initialize(response, bot)
        @response = response
        @bot = bot
      end

      def handle
        bot.history.messages << Bots::Message.new("assistant", dig_for_content)
        dig_for_content
      end
    end
  end
end
