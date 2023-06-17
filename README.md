# FuncBot

Short description and motivation.

## Usage

### Generate a new function

```bash
rails g func_bot:function <function_name>
```

- Update the function in `lib/func_bot/functions/<function_name>.rb`

  - Functions should return a JSON string in a similar format to the one below, but relevant to your function

  ```ruby
         weather_info = {
            location: "Miami, FL",
            temperature: 98, # sample response from the API
            forecast: ["sunny", "windy"] # sample response from the API

          }

          JSON.dump(weather_info)
  ```

- Update your new function in the list of functions in `lib/func_bot/functions/list.yml`.
  - This is the list of functions that will be available to the bot
  - Adding good descriptions to the functions will help the bot infer when to use which function
- If the user asks a question that is not related to a function in your list, the bot will give a response from ChatGPT, without getting input from a function.

`bin/rails c`

```ruby
# Uses sample function GetCurrentWeather, can be found in lib/generators/func_bot/templates/get_current_weather.rb

bot = FuncBot::Chat.new "What's the weather like in Miami, FL"
#<FuncBot::Chat:0x000000010d2d27e8 @history=[], @prompt="What's the weather like in Miami, FL", @role="user">
bot.open
=> "The current weather in Miami, FL is sunny and windy with a temperature of 98 degrees Fahrenheit."

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
