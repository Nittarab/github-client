module Github
  # Error class to raise client errors
  Error = Class.new(StandardError)
  AuthenticationError = Class.new(Error)

  # @return [Github::Configuration] Configuration singleton
  mattr_accessor :configuration

  #
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

  #
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
