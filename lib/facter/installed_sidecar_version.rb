Facter.add(:installed_sidecar_version) do
  setcode do
    command = '/usr/bin/graylog-sidecar -version'
    version = ''

    begin
      version_string = Facter::Core::Execution.execute(command)
      Facter.debug("Got version #{version_string}")

      version = %r{^[^0-9]*([0-9.]*).*}.match(version_string)[1]
    rescue Facter::Core::Execution::ExecutionFailure => e
      Facter.debug("Failed to run #{command} (#{e}). Returning nothing.")
    end

    Facter.debug("Found version #{version}")

    version
  end
end