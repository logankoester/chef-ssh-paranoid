package('libssh2') { action :install }
package('openssh') { action :install }

execute 'Generate non-existent host keys for all key types' do
  command 'ssh-keygen -A'
  not_if { ::File.exists?("/etc/ssh/ssh_host_key") &&
           ::File.exists?("/etc/ssh/ssh_host_key.pub") }
end

if node[:ssh][:supervisor]
  supervisor_service 'sshd' do
    action [:enable, :start]
    directory '/'
    command '/usr/bin/sshd -D'
  end
else
  service 'sshd' do
    supports status: true, start: true, stop: true, restart: true, reload: true
    action [:enable]
  end
end

template '/etc/issue' do
  mode 0755
  source 'banner.erb'
  if node[:ssh][:supervisor]
    notifies :restart , resources(:supervisor_service => 'sshd')
  else
    notifies :restart , resources(:service => 'sshd')
  end
end

template '/etc/ssh/sshd_config' do
  mode '0644'
  source 'sshd_config.erb'
  if node[:ssh][:supervisor]
    notifies :restart , resources(:supervisor_service => 'sshd')
  else
    notifies :restart , resources(:service => 'sshd')
  end
end
