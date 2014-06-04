package('libssh2') { action :install }
package('openssh') { action :install }

service 'sshd' do
  provider Chef::Provider::Service::Systemd if node['platform'] =~ /arch|manjaro/
  supports status: true, start: true, stop: true, restart: true, reload: true
  action [:enable]
end

cookbook_file '/etc/issue' do
  source 'banner'
  mode 0755
  notifies :restart , resources(:service => 'sshd')
end

template '/etc/ssh/sshd_config' do
  mode '0644'
  source 'sshd_config.erb'
  notifies :restart, resources(:service => 'sshd')
end
