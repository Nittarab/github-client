# frozen_string_literal: true

require_relative "client/"

module Github
  # Github API client
  class Client
    class Error < StandardError; end

    # @return [Configuration] Global singleton configuration
    attr_reader :configuration

    #
    # Initializes the client
    #
    # @param [Configuration] configuration API client configuration
    #
    def initialize(configuration)
      @configuration = configuration
      @connection = Github::Connection.new(configuration)
    end


    def get_events(user_name:)
      path = "users/#{user_name}/events/public"
      @connection.get(path: path)
    end


  end
end
