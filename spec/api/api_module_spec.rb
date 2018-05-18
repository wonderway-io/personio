require 'spec_helper'

RSpec.describe ApiModule do
  before(:all) do
    Personio.configure do |personio_config|
      personio_config.mocks = {}
    end
  end

  it 'should update the auth token on api call' do
    Personio.employees.all
    expect(Personio.configuration.auth_token).to eq('123')
  end
end
