# Api errors to throw on http failures
module ApiErrors
  # Custom error to throw unless personio returns a success
  class PersonioServerError < StandardError
    def initialize(msg = 'Personio responded with an error.')
      super
    end
  end

  # Authentication error that is thrown for a response status of 403
  class PersonioAuthenticationError < StandardError
    def initialize(msg = 'Personio authentication failure.')
      super
    end
  end
end
