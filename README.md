# ssh-paranoid cookbook

An ssh configuration with sensible paranoia. Tested with Arch Linux.

## Installation

Using [Berkshelf](http://berkshelf.com/), add the `ssh` cookbook to your Berksfile.

```ruby
    cookbook 'ssh-paranoid', git: 'git@github.com:logankoester/chef-ssh-paranoid.git'
```

Then run `berks` to install it.

## Default

An ssh configuration with sensible paranoia. See /etc/ssh/sshd_config for details.

* Password authentication disabled by default
* SSH access as root user is forbidden (always use sudo)
* Empty passwords are not permitted
* Protocol 2 only
* Custom /etc/issue banner
* Idle clients will not be disconnected unless they are
  unreachable for 3 minutes.

### Usage

Add `recipe[ssh::default]` to your run list.

## Sshguard

After too many failed login attempts, Sshguard will ban the offending host
on port `node[:ssh][:port]` for a limited time, starting at 7 minutes and
doubling each time he is banned again.

### Usage

Add `recipe[ssh::sshguard]` to your run list.

## Attributes

* `node[:ssh][:port]` - Port to listen (default 22)
* `node[:ssh][:password_authentication]` - `yes` or `no`
* `node[:ssh][:banner]` - Greeting / banner string to be displayed upon connection

## Resources

* https://wiki.archlinux.org/index.php/Sshd
* https://wiki.archlinux.org/index.php/SSH_Keys
* https://wiki.archlinux.org/index.php/Sshguard
* https://wiki.archlinux.org/index.php/Iptables
* http://www.sshguard.net

## Development

    # Start an archlinux vm
    cd ssh
    vagrant up 

    # Edit files...

    # Run again
    vagrant provision 

    # Verify
    vagrant ssh

## Author

Author:: Logan Koester (<logan@logankoester.com>)
