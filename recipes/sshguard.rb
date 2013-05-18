#
# Cookbook Name:: ssh
# Recipe:: sshguard
#
# Copyright (C) 2013 Logan Koester
# 
# All rights reserved - Do Not Redistribute
#

package('sshguard') { action :install }

execute 'Create iptables chain sshguard' do
  command 'iptables -N sshguard'
  returns [0,1]
end

execute 'Append iptables rule unless already exists' do
  command "iptables -A INPUT -p tcp --dport #{node[:ssh][:port]} -j sshguard; iptables-save > /etc/iptables/iptables.rules"
  not_if "iptables -C INPUT -p tcp --dport #{node[:ssh][:port]} -j sshguard"
end

execute 'Create ip6tables chain sshguard' do
  command 'ip6tables -N sshguard'
  returns [0,1]
end

execute 'Append ip6tables rule unless already exists' do
  command "ip6tables -A INPUT -p tcp --dport #{node[:ssh][:port]} -j sshguard; ip6tables-save > /etc/iptables/ip6tables.rules"
  not_if "ip6tables -C INPUT -p tcp --dport #{node[:ssh][:port]} -j sshguard"
end

service 'iptables' do
  provider Chef::Provider::Service::Systemd if node['platform'] == 'arch'
  supports status: true, start: true, stop: true, restart: true, reload: true
  action [:enable, :start]
end

service 'ip6tables' do
  provider Chef::Provider::Service::Systemd if node['platform'] == 'arch'
  supports status: true, start: true, stop: true, restart: true, reload: true
  action [:enable, :start]
end

service 'sshguard' do
  provider Chef::Provider::Service::Systemd if node['platform'] == 'arch'
  supports status: true, start: true, stop: true, restart: true, reload: true
  action [:enable, :start]
end
