# # encoding: utf-8

# Inspec test for recipe prestashop::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(80) do
  it { should be_listening }
end

describe file('/usr/bin/docker') do
  let(:node) { json('/tmp/kitchen/nodes/default-ubuntu-1804.json').default }
  before do
    skip if node['prestashop']['use_docker'] == false
  end
  it { should be_file }
  it { should be_executable }
end

# check whether Docker daemon is running:
describe command('systemctl is-active docker') do
  let(:node) { json('/tmp/kitchen/nodes/default-ubuntu-1804.json').default }
  before do
    skip if node['prestashop']['use_docker'] == false
  end
  its(:stdout) { should match /active/ }
end

describe docker_container('mysql_container') do
  let(:node) { json('/tmp/kitchen/nodes/default-ubuntu-1804.json').default }
  before do
    skip if node['prestashop']['use_docker'] == false
  end
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'mysql' }
  its('ports') { should include "0.0.0.0:3306->3306/tcp" }
end

# check whether Prestashop container is running
# check whether Prestashop is listening on port 80
describe docker_container('prestashop_container_a') do
  let(:node) { json('/tmp/kitchen/nodes/default-ubuntu-1804.json').default }
  before do
    skip if node['prestashop']['use_docker'] == false
  end
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'prestashop/prestashop' }
  its('ports') { should include "0.0.0.0:80->80/tcp" }
end
