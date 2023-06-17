require_relative "functions/list"
require_relative "functions/get_current_weather"
require_relative "chat"

module FuncBot
  class Engine < ::Rails::Engine
    isolate_namespace FuncBot
  end
end
