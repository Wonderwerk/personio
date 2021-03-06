require 'json'
require 'spec_helper'

RSpec.describe EmployeesApi do
  before(:all) do
    Personio.configure do |personio_config|
      personio_config.mocks = {
        employees: JSON.parse(
          File.read('spec/mocks/employees.json')
        )
      }
    end
  end

  it 'should return two employees' do
    employees = Personio.employees.all
    expect(employees.count).to eq(2)
  end

  it 'should contain a supervisor' do
    employees = Personio.employees.all
    supervisor = employees.first.supervisor
    expect(supervisor.email).to eq('sarah.becker@wonderwerk-sample.com')
  end

  it 'should contain a department' do
    employees = Personio.employees.all
    user = employees.first
    expect(user.department).to eq('HR')
  end

  it 'should contain an office' do
    employees = Personio.employees.all
    user = employees.first
    expect(user.office).to eq('London')
  end
end
