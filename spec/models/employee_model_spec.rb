require 'json'
require 'spec_helper'

RSpec.describe EmployeeModel do
  before(:all) do
    employee = JSON.parse(
      File.read('spec/mocks/employees_api_response.json')
    )['data'].first
    @model = EmployeeModel.new employee['attributes']
  end

  it 'should set all fields on creation' do
    expect(@model.id).to eq(317_603)
    expect(@model.first_name).to eq('Sarah')
    expect(@model.last_name).to eq('Becker')
    expect(@model.email).to eq('sarah.becker@wonderwerk-sample.com')
    expect(@model.status).to eq(:active)
    expect(@model.position).to eq('HR Manager')
    expect(@model.employment_type).to eq('internal')
    expect(@model.department).to eq('HR')
    expect(@model.office).to eq('London Office')
  end

  it 'should contain a correct supervisor' do
    supervisor = @model.supervisor
    expect(supervisor).to be_instance_of(EmployeeModel)
    expect(supervisor.id).to eq(317_600)
    expect(supervisor.first_name).to eq('Robert')
    expect(supervisor.last_name).to eq('Jacobs')
    expect(supervisor.email).to eq('robert.jacobs@wonderwerk-sample.com')
  end
end
