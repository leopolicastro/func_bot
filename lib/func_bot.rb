require "openai"

require "func_bot/version"
require "func_bot/engine"

require_relative "func_bot/bot"
require_relative "func_bot/bots/client"
require_relative "func_bot/bots/history"
require_relative "func_bot/bots/message"
require_relative "func_bot/functions/base_function"
require_relative "func_bot/functions/list"
require_relative "func_bot/handlers/base_handler"
require_relative "func_bot/handlers/bot_handler"
require_relative "func_bot/handlers/function_handler"

module FuncBot
end
