# # a service named default
describe command('docker images') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/busybox/) }
end

describe command('docker ps -a') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/an_echo_server/) }
end

# service A
describe command('docker --host=unix:///var/run/docker-one.sock images') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^hello-world/) }
  its(:stdout) { should_not match(/^alpine/) }
end

describe command('docker --host=unix:///var/run/docker-one.sock ps -a') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/hello-world/) }
  its(:stdout) { should_not match(/an_echo_server/) }
end

# # service B
# describe command('docker --host=unix:///var/run/docker-two.sock images') do
#   its(:exit_status) { should eq 0 }
#   its(:stdout) { should_not match(/^hello-world/) }
#   its(:stdout) { should match(/^alpine/) }
# end

# describe command('docker --host=unix:///var/run/docker-two.sock ps -a') do
#   its(:exit_status) { should eq 0 }
#   its(:stdout) { should_not match(/hello-world/) }
#   its(:stdout) { should match(/an_echo_server/) }
# end
