# Useful RTX Series Lua Scripts

## Intallation

1. Make directory in the RTX Router with SSH

```
ssh {user}@{ip_address}
$ administrator # Type your administrator's password.
$ make directory lua
exit # Log out from the administrator.
exit # Exit from ssh.
```

2. Copy the lua script to RTX Router with TFTP

```
tftp -i {ip_address} put ./{local_script_name.lua} /lua/{remote_script_name}.lua
```

## nat-table-to-syslog.lua

This script outputs the number of ports used in the NAT table to syslog.  
You can run the lua script every hour by executing the following command.

```
schedule at 1 */* *:0 * lua /lua/nat-table-to-syslog.lua
```
