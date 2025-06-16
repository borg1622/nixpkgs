# Nixos Cfg

## Folders

### `/hardware`
Hardware related configuration, e.g. Raspberry Pi, VirtualBox, etc.

### `/lib`
static configuration files, to be placed into `etc` or `$HOME`.

### `/machines`
Machines descriptions. Referring to instances of (virtual) devices.
Each machine includes
- a hardware config
- one or more profiles
- any number of services
- secrets
- users


### `/profiles`
machine software profiles

### `/secrets`


### `/services`
configuration of machine services/software

### `/users`
All users configuration.



# ToDo's

## Clients

[*] configure firefox w addons
[*] configure keepass


## Servers

### Firewall
[*] fwknop | port knocking service
[*] fail2ban
[*] restrict incoming nad outgoin connections to certain client ips

## Common features
### Firewall
[*] add common firewall rules
