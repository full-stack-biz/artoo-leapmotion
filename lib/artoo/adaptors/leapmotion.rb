require 'artoo/adaptors/adaptor'
require 'celluloid/websocket/client'

module Artoo
  module Adaptors
    # Connect to a leapmotion device
    # @see device documentation for more information
    class Leapmotion < Adaptor
      attr_reader :leap

      # Creates a connection with device
      # @return [Boolean]
      def connect
        @leap = Celluloid::WebSocket::Client.new("ws://#{port.host}:#{port.port}/v6.json")

        super
      end

      # Closes connection with device
      # @return [Boolean]
      def disconnect
        leap.close

        super
      end

      # Uses method missing to call device actions
      # @see device documentation
      def method_missing(method_name, *arguments, &block)
        leap.send(method_name, *arguments, &block)
      end
    end
  end
end
