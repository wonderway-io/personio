require_relative 'api_module'
require_relative '../models/employee_model'

# Employees Api
class EmployeesApi
  include ApiModule

  # Returns all employees from personio
  # @return [Array<{EmployeeModel employee}>] Queries all employees from
  #    personio and returns an array of employee models
  def all
    # Query employees
    employees = get('/company/employees').map do |entry|
      EmployeeModel.new entry['attributes']
    end

    # Update supervisors from list of employees
    assign_supervisors! employees

    # Return employees
    employees
  end

  private

  def assign_supervisors!(employees)
    employees_by_email = Hash[employees.map { |e| [e.email, e] }]
    employees.each do |employee|
      next unless employee.supervisor
      employee.supervisor = (
        employees_by_email[employee.supervisor.email] ||
        employee.supervisor
      )
    end
  end
end
