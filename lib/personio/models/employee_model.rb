# Employee Model
class EmployeeModel
  # Personio fields to set on the employee model
  FIELDS = %i[
    id first_name last_name email status position supervisor employment_type
  ].freeze

  # @return [Integer] The personio id
  attr_accessor :id
  # @return [String] The employees first name
  attr_accessor :first_name
  # @return [String] The employees last name
  attr_accessor :last_name
  # @return [String] The employees email
  attr_accessor :email
  # @return [Symbol] The employees status (inactive/onboarding/active)
  attr_accessor :status
  # @return [String] The employees position (role in the company)
  attr_accessor :position
  # @return [{EmployeeModel employee}] The employees supervisor
  attr_accessor :supervisor
  # @return [String] The employees employment type
  attr_accessor :employment_type

  def initialize(args)
    # Auto set plain text fields
    args.each do |key, value|
      instance_variable_set("@#{key}", value['value']) \
        if EmployeeModel::FIELDS.include?(key.to_sym)
    end

    # Overwrite fields that require conversion
    @status = @status.to_sym unless @status.nil?
    @supervisor = EmployeeModel.new(@supervisor['attributes']) unless \
      @supervisor.nil? || @supervisor.instance_of?(EmployeeModel)
    @birthday = Time.parse(@birthday) unless @birthday.nil?
  end
end
