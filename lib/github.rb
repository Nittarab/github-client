# frozen_string_literal: true

require 'zeitwerk'

# @note I have added a tag to it's easier to auto-reload if used with other Zeitwerk loader
loader = Zeitwerk::Loader.new
loader.push_dir File.join(__dir__)
loader.tag = 'service_bus'
loader.setup

module Github
  # Error class to raise client errors
  Error = Class.new(StandardError)

  # @return [Github::Configuration] Configuration singleton
  def self.configuration
    @configuration
  end

  # @param [Github::Configuration]
  def self.configuration=(configuration)
    @configuration = configuration
  end

  # Configures  globally
  #
  # @yields [Github::Configuration] configuration object
  # @return [Github] self``
  #
  def self.configure(endpoint:, **options)
    self.configuration ||= Github::Configuration.new(endpoint: endpoint, **options)
    yield(configuration) if block_given?
    self
  end

  # Creates a client with the global configuration
  #
  # @raise [ArgumentError] if configuration is not set
  # @return [Github::Client] API client
  #
  def self.client
    raise ArgumentError, 'Github not configured' unless configuration

    Client.new(configuration)
  end
end
