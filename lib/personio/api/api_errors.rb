# Api errors to throw on http failures
module ApiErrors
  # Custom error to throw unless personio returns a success
  class PersonioServerError < StandardError
    def initialize(msg = 'Personio responded with an error.')
      super
    end
  end
end
