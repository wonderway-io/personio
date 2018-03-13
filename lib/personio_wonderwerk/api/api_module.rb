require 'httparty'
require_relative 'api_errors'

# Api mixin to abstract query functionality
module ApiModule
  # @param config [Object] Personio wonderwerk configuration object
  def initialize(config)
    @config = config
  end

  def get(path)
    authenticate unless @config.auth_token

    # Query the api
    response = HTTParty.get(
      "https://api.personio.de/v1#{path}",
      headers: {
        'Authorization' => "Bearer #{@config.auth_token}"
      }
    )

    # Check if successful
    check_response(response)

    # Update auth token
    @config.auth_token = response.headers['Authorization'].gsub('Bearer ', '')

    # Return response
    response.parsed_response['data']
  end

  private

  def authenticate
    response = HTTParty.post(
      'https://api.personio.de/v1/auth?' \
        "client_id=#{@config.client_id}&" \
        "client_secret=#{@config.client_secret}"
    )

    # Check if successful
    check_response(response)

    # Update auth token
    @config.auth_token = response.parsed_response['data']['token']
  end

  def check_response(response)
    parsed_response = response.parsed_response

    raise ApiErrors::PersonioServerError, parsed_response['error']['message'] \
      unless parsed_response['success']
  end
end
