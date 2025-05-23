require 'spec_helper'
require 'socket'

if ['ubuntu'].include?(os[:family])

  # Check configuration

  describe file('/etc/graylog/sidecar/sidecar.yml') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to contain('TESTTAG') }
    its(:content_as_yaml) { is_expected.to include('tls_skip_verify' => true) }
    its(:content_as_yaml) { is_expected.to include('log_max_age' => 4711) }
    its(:content_as_yaml) { is_expected.to include('log_rotation_time' => 86_400) }
    its(:content_as_yaml) { is_expected.to include('backends') }
    its(:content_as_yaml) { is_expected.to include('node_id' => Socket.gethostname) }
  end

  # Check service

  describe service('graylog-sidecar') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

end
