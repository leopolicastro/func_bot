# FuncBot

FuncBot is a Rails gem built on top of [Ruby OpenAI](`https://github.com/alexrudall/ruby-openai`) that allows you to create chat bots that can answer questions by calling on functions that you define.

## Usage

### Generate a new function

```bash
rails g func_bot:function <function_name>
```

- Update the function in `lib/func_bot/functions/<function_name>.rb`

  - Here's a sample function that returns the current weather in a location that the user asks about.
  - The function takes in the response from the user and returns a JSON string that will be parsed by the bot and returned to the user.
  - A function can be as simple or as complex as you want it to be. You can call external APIs, parse the response, and return a JSON string that the bot will process and return to the user.
  - All functions must have a `call` method that takes in the response from the user and returns a JSON string.
    - Outside of the `call` method, you can define any other methods that you want to use in your function.
  - Here's a sample function that returns the current weather for the given location.

    ```ruby
    module FuncBot
      module Functions
        class WeatherFunction < BaseFunction
          def execute
            weather_info = {
              location: parsed_response["location"],
              temperature: 98,
              forecast: ["sunny", "windy"]
            }

            JSON.dump(weather_info)
          end
        end
      end
    end
    ```

  - The `parsed_response` and `response` methods are available to any Function Class you generate.
    - `parsed_response` is a hash that contains the parsed response from OpenAI.
    - `response` is the raw response from OpenAI.

- Update your new function in the list of functions in `lib/func_bot/functions/list.yml`.
  - This is the list of functions that will be available to the bot with every request
  - Adding good descriptions to the functions will help the bot infer when to use which function
- If the user asks a question that is not related to a function in your list, the bot will give a response from ChatGPT, without getting input from a function.

`bin/rails c`

```ruby
irb(main):001:0> bot = FuncBot::Bot.new
=> #<FuncBot::Bot:0x0000000105ecd8e8 @history=#<FuncBot::Bots::History:0x0000000105ecd848 @history=[]>>
irb(main):002:0> bot.ask "What's the weather like in Miami, FL?"
=> "The current weather in Miami, FL is sunny and windy with a temperature of 98 degrees."
irb(main):003:0>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "func_bot"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install func_bot
```

## Setup

```bash
rails g func_bot:install

```

## Testing

```bash
cd spec/dummy
bin/setup
bundle exec rspec
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
