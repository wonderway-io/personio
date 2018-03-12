require 'json'

module ApiHelper
  def employees
    result = File.read('spec/mocks/employees.json')
    JSON.parse(result)
  end
end
