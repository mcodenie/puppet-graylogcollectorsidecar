require 'spec_helper'

# Check, if configuration was altered

describe file('/etc/graylog/sidecar/sidecar.yml') do
  it { is_expected.to exist }
  it { is_expected.to be_file }
  it { is_expected.to contain('- TESTTAG') }
  it { is_expected.not_to contain('- test') }
end
