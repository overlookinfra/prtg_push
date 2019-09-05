
# PRTG Push

## Table of Contents

1. [Description](#description)
2. [Setup](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

## Description

[PRTG Network Monitor](https://www.paessler.com/prtg) is IT monitoring software for Windows that can monitor many metrics on servers and networking devices. It provides a flexible HTTP push sensor that allows administrators to monitor more metrics than PRTG provides out of the box. The PRTG Push Puppet module provides several defined Puppet resources for HTTP push sensors to run on *nix systems.

[See Paessler's documentation on HTTP push sensors.](https://www.paessler.com/manuals/prtg/http_push_data_advanced_sensor)

## Setup

Setup with prtg_push is minimal; install the module as you would any other module, `include prtg_push` in your Puppet code and use the defined types provided (see #usage).

## Usage

You can run an arbitrary command with the `command_check` defined type:

```puppet
prtg_push::command_check { '':
  command  => 'cat /etc/openvpn/my-vpn.log | grep 10. | wc -l',
  hostname => 'prtg.contoso.com',
  port     => '5050',
  token    => 'my-prtg-token',
}
```

The `newest_file` defined type allows you to monitor the age of a given file:

```puppet
prtg_push::newest_file { 'My backup':
  file_ext  => '.tar.gz',
  check_dir => '/opt/backups/,
  hostname  => 'prtg.contoso.com',
  port      => '5050',
  token     => 'my-prtg-token',
}
```

If you want to monitor whether a given service is running, you can use the `service_check` defined type:

```puppet
prtg_push::service_check { 'sshd':
  hostname  => 'prtg.contoso.com',
  port      => '5050',
  token     => 'my-prtg-token',
}
```

## Limitations

This module has only been tested on Ubuntu 16.04 machines.
