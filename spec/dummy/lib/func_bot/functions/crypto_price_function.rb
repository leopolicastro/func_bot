module FuncBot
  module Functions
    class CryptoPriceFunction < BaseFunction
      def execute
        data = {
          coin: parsed_response["coin"],
          price: rand(50000)
        }
        JSON.dump(data)
      end
    end
  end
end
