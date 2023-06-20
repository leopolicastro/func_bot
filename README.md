# FuncBot

FuncBot is a Rails gem built on top of the [ruby-openai](https://github.com/alexrudall/ruby-openai) gem. It allows you to easily create chatbots that can answer questions by calling on functions you define. It's goal is to provide a simple interface to consume [OpenAI's Function Calling API](https://openai.com/blog/function-calling-and-other-api-updates?ref=upstract.com).

## Usage

- Generate a new function

```bash
rails g func_bot:function <function_name>
```

- Update the function in `app/lib/func_bot/functions/<function_name>.rb`

  - A function can be as simple or as complex as you need it to be. Your bot will process the results and express them to the user.
  - All functions must have an `execute` method.
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

  - The `parsed_response` and `response` methods are available to all functions.
    - `parsed_response` is a hash that contains the response relevant to your function from OpenAI.
    - `response` is the raw response from OpenAI.
  - Functions also have access to the `bot` attribute which returns the instance of the bot that called the function.

    - This is useful if you need to access the bot's history or other methods.
    - There might be times when you need to ask gpt a question from within a function, but you don't want to trigger the function again. You can set the `bot.include_functions` attribute to false before asking the question and then set it back to true after.

    ```ruby
    module FuncBot
      module Functions
        class SomeFunction < BaseFunction
          def execute
            bot.include_functions = false
            response = bot.ask "Some question that you don't want to trigger any functions for"
            bot.include_functions = true
            do_something_with_response(response)
            ....
          end
        end
      end
    end
    ```

- Update your new function in the list of functions in `app/lib/func_bot/functions/list.yml`.
  - This list of functions will be available to the bot with every request.
  - Adding good descriptions to the functions will help the bot infer when to use which function.
- If the user asks a question that is not related to a function in your list, the bot will just ask ChatGPT.

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

- Make sure to add your OpenAI API key to your credentials file or update the `config/initializers/openai.rb` file accordingly.

```yml
openai:
  api_key: your-private-key
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
