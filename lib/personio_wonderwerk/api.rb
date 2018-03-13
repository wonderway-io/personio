require_relative 'api/employees_api'

# Personio API as instance
class PersonioWonderwerkApi
  attr_accessor :config

  def initialize(args = {})
    @config = PersonioWonderwerk::Configuration.new(args)
  end

  def employees
    @employees_api ||= EmployeesApi.new(@config)
  end
end
