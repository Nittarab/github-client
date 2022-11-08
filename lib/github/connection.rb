# frozen_string_literal: true

require 'faraday'

module Github
  #  The connection Class used by the Client to handle the network connection
  class Connection
    attr_reader :configuration

    # Initializes the connection wrapper
    #
    # @param [Github::Configuration] configuration Github configuration object
    #
    def initialize(configuration)
      @configuration = configuration
      @connection = Faraday.new(url: url, proxy: configuration.proxy).tap do |connection|
        connection.url_prefix = url
        connection.use Faraday::Response::RaiseError
        connection.request :json
        connection.response :json, content_type: /\bjson(; charset=utf-8)?$/
        connection.response :logger, configuration.logger, { headers: true, bodies: true } if configuration.debug?
      end
    end

    #
    # Performs a GET request
    #
    # @param [String] path relative URL path
    #
    # @return [Hash] parsed JSON response
    #
    def get(path:, params: nil)
      params = JSON[params] if params
      url = @connection.build_url(path, params)
      json_request(method: :get, url: url).body
    end

    #
    # Performs a POST request
    #
    # @param [String] path relative URL path
    # @param [Object] data payload to be sent as JSON
    #
    # @return [Hash] parsed JSON response
    #
    def post(path:, data: nil)
      data = JSON[data] if data
      json_request(method: :post, url: path, data: data).body
    end

    private

    #
    # Performs a JSON request
    #
    # @param [Symbol] method HTTP request method
    # @param [String] url relative URL path
    # @param [Object|Nil] data payload to be sent as JSON
    #
    # @return [Hash] deserialized JSON response
    #
    def json_request(method:, url:, data: nil)
      @connection.public_send(method, url, data) do |request|
        request.headers['Accept'] = 'application/json'
        request.headers['Content-Type'] = 'application/json'
      end
    rescue Faraday::ClientError, Faraday::ServerError => e
      raise Github::Error, e
    end
  end
end