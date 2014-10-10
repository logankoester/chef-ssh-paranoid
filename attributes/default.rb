default[:ssh][:port] = 22
default[:ssh][:password_authentication] = 'no'
default[:ssh][:supervisor] = false
default[:ssh][:use_pam] = true
default[:ssh][:banner] = <<BANNER
    __    ____  __ __   _ 
   / /   / __ \/ //_/  (_)___
  / /   / / / / ,<    / / __ \
 / /___/ /_/ / /| |_ / / /_/ /
/_____/_____/_/ |_(_)_/\____/

BANNER
