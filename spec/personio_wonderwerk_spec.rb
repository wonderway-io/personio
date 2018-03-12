require 'spec_helper'

RSpec.describe PersonioWonderwerk do
  it 'is configurable' do
    expect(PersonioWonderwerk.configuration).not_to be(nil)
  end

  it 'saves the credentials' do
    PersonioWonderwerk.configure do |config|
      config.client_secret = 'client_secret'
      config.client_id = 'client_id'
    end

    configuration = PersonioWonderwerk.configuration
    expect(configuration.client_secret).to eq('client_secret')
    expect(configuration.client_id).to eq('client_id')
  end

  it 'returns the employee api on employees' do
    expect(PersonioWonderwerk.employees).to be_instance_of(EmployeesApi)
  end
end
