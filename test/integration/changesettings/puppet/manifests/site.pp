$_use_auth = $facts['github_use_auth'] ? {
  # lint:ignore:quoted_booleans
  'true'  => true,
  # lint:endignore
  default => false,
}

$_use_oauth = $facts['github_use_oauth'] ? {
  # lint:ignore:quoted_booleans
  'true'  => true,
  # lint:endignore
  default => false,
}

class {
  'graylogcollectorsidecar':
    api_url         => 'https://graylog.company.com',
    version         => '1.1.5',
    tags            => [
      'TESTTAG',
    ],
    tls_skip_verify => true,
    log_max_age     => 4711,
}
