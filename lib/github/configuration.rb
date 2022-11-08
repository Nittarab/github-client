# frozen_string_literal: true

require 'logger'
require 'uri'

module Github
  # Configuration class for the Github client
  class Configuration
    attr_reader :endpoint
    attr_accessor :proxy_host,
                  :proxy_port,
                  :logger,
                  :debug

    # Initializes a configuration object
    #
    # @param [String|URI] endpoint for github
    # @param [Logger] logger Logger instance
    # @param [Boolean] debug
    # @param [String] proxy_host Hostname for proxy
    # @param [String|Integer] proxy_port Port for proxy
    def initialize(
      endpoint:,
      logger: Logger.new($stdout),
      debug: false,
      proxy_host: nil,
      proxy_port: nil
    )
      self.endpoint = endpoint
      self.logger = logger
      self.debug = debug
      self.proxy_host = proxy_host
      self.proxy_port = proxy_port
    end

    # Sets the endpoint
    #
    # @param [String|URI] value The endpoint URL
    #
    # @return [URI] the set endpoint URI
    # @raise [ArgumentError] if the value is blank
    #
    def endpoint=(value)
      raise ArgumentError, 'endpoint is not a Uri' unless value =~ URI::DEFAULT_PARSER.make_regexp

      @endpoint = URI(value.to_s).freeze
    end

    # Returns a proxy connection string.
    #
    # @return [String|nil] proxy connection string, or nil if no proxy set.
    #
    def proxy
      return unless proxy_host

      [proxy_host, proxy_port].compact.join(':')
    end

    # Returns true if debugging should be enabled, logs more details
    #
    # @return [Boolean] true if debugging should be enabled
    #
    def debug?
      debug
    end
  end
end
