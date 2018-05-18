require_relative 'api_module'
require 'webmock'
include WebMock::API

# Module to stub the api responses
module ApiStub
  def self.initialize(mocks)
    WebMock.enable!

    WebMock.stub_request(:any, /api.personio.de/)
    mock_auth
    mock_employees(mocks)
  end

  def self.mock_auth
    WebMock
      .stub_request(:post, %r{api.personio.de/v1/auth}) \
      .to_return mock_success(
        token: 'mocked_token'
      )
  end

  def self.mock_employees(mocks = {})
    return_value = (mocks[:employees] || []).map { |e| create_employee(e) }
    WebMock
      .stub_request(:get, %r{api.personio.de/v1/company/employees})
      .to_return mock_success(return_value)
  end

  def self.create_employee(employee)
    {
      type: 'Employee',
      attributes: Hash[employee.map do |key, value|
        [key, {
          label: key.split('_').map(&:capitalize).join(' '),
          value: key == 'supervisor' ? create_employee(value) : value
        }]
      end]
    }
  end

  def self.mock_success(data)
    {
      body: {
        success: true,
        data: data
      }.to_json,
      headers: {
        Authorization: 'Bearer 123',
        content_type: 'application/json'
      }
    }
  end

  def self.mock_error(message)
    {
      body: {
        success: false,
        error: {
          message: message
        }
      }.to_json
    }
  end
end
