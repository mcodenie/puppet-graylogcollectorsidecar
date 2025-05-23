require 'spec_helper'
require 'socket'

describe 'graylogcollectorsidecar' do
  context 'on RedHat/x86_64' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystem: 'RedHat',
        operatingsystemmajrelease: '7',
        os: {
          family: 'RedHat',
          release: {
            major: '7',
          },
        },
        architecture: 'x86_64',
        installed_sidecar_version: '',
      }
    end

    let(:params) do
      {
        version: '0.1.0-beta.2',
        api_url: 'http://graylog.example.com',
        log_path: '/var/log/graylog',
        tags: [
          'default',
        ],
      }
    end

    it { is_expected.to compile }
    it {
      is_expected.to contain_githubreleases_download('/tmp/graylog-sidecar.rpm')
    }
    it { is_expected.to contain_package('graylog-sidecar') }
    it { is_expected.to contain_service('graylog-sidecar') }

    expected_content = <<EOT
---
server_url: http://graylog.example.com
update_interval: 10
tls_skip_verify: false
send_status: true
node_id: #{Socket.gethostname}
collector_id: file:/etc/graylog/sidecar/node-id
cache_path: "/var/cache/graylog-sidecar"
log_path: "/var/log/graylog"
log_rotation_time: 86400
log_max_age: 604800
tags:
- default
backends:
- name: nxlog
  enabled: false
  binary_path: "/usr/bin/nxlog"
  configuration_path: "/var/lib/graylog-sidecar/generated/nxlog.conf"
- name: filebeat
  enabled: true
  binary_path: "/usr/lib/graylog-sidecar/filebeat"
  configuration_path: "/var/lib/graylog-sidecar/generated/filebeat.yml"
- name: auditbeat
  enabled: true
  binary_path: "/usr/lib/graylog-sidecar/auditbeat"
  configuration_path: "/var/lib/graylog-sidecar/generated/auditbeat.yml"
EOT
    it {
      is_expected.to contain_file('/etc/graylog/sidecar/sidecar.yml').with_content(
        expected_content,
      )
    }
  end

  context 'on RedHat/i386' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        architecture: 'i386',
        operatingsystem: 'RedHat',
        operatingsystemmajrelease: '7',
        os: {
          family: 'RedHat',
          release: {
            major: '7',
          },
        },
        installed_sidecar_version: '',
      }
    end

    let(:params) do
      {
        version: '0.1.0-beta.2',
        api_url: 'http://graylog.example.com',
        tags: [
          'default',
        ],
      }
    end

    it {
      is_expected.to contain_githubreleases_download('/tmp/graylog-sidecar.rpm')
    }
    it { is_expected.to contain_package('graylog-sidecar') }
    it { is_expected.to contain_service('graylog-sidecar') }
  end
end
