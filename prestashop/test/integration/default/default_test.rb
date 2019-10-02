# # encoding: utf-8

# Inspec test for recipe prestashop::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('apache2') do
  it { should be_installed }
end

# This is an example test, replace with your own test.
describe user('root') do
  it { should exist }
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end


require 'spec_helper'

describe file('/usr/bin/docker') do
  it { should be_file }
  it { should be_executable }
end

describe command('/usr/bin/docker version') do
  its(:stdout) { should match /Version:      1.12.1/ }
end
