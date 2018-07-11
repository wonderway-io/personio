# Employee Model
class EmployeeModel
  # Personio fields to set on the employee model
  FIELDS = %i[
    id first_name last_name email status position supervisor employment_type
    department office
  ].freeze

  # @return [Integer] The personio id
  attr_accessor :id
  # @return [String] The employees first name
  attr_accessor :first_name
  # @return [String] The employees last name
  attr_accessor :last_name
  # @return [String] The employees email
  attr_accessor :email
  # @return [String] The employees employment type
  attr_accessor :employment_type
  # @return [String] The employees position (role in the company)
  attr_accessor :position
  # @return [Symbol] The employees status (inactive/onboarding/active)
  attr_reader :status
  # @return [{EmployeeModel employee}] The employees supervisor
  attr_reader :supervisor
  # @return [String] The employees department name
  attr_reader :department
  # @return [String] The employees office name
  attr_reader :office

  def initialize(args)
    # Auto set plain text fields
    args.each do |key, value|
      send("#{key}=", value['value']) \
        if EmployeeModel::FIELDS.include?(key.to_sym)
    end
  end

  def status=(value)
    value = value.to_sym unless value.nil?
    @status = value
  end

  def supervisor=(value)
    value = EmployeeModel.new(value['attributes']) unless \
      value.nil? || value.instance_of?(EmployeeModel)
    @supervisor = value
  end

  def department=(value)
    value = value['attributes']['name'] unless value.nil?
    @department = value
  end

  def office=(value)
    value = value['attributes']['name'] unless value.nil?
    @office = value
  end
end
