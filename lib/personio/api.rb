require_relative 'api/employees_api'

# Personio API as instance
class PersonioApi
  attr_accessor :config

  def initialize(args = {})
    @config = Personio::Configuration.new(args)
  end

  def employees
    @employees_api ||= EmployeesApi.new(@config)
  end
end
