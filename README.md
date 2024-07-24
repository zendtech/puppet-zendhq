# zend/zendhq Puppet Module

This Puppet module manages ZendHQ, a Zend product add-on for ZendPHP Enterprise.

## Table of Contents

1. [What zendhq affects](#what-zendhq-affects)
1. [Usage](#usage)
1. [Reference](#reference)

## What zendhq affects

This module adds the ZendPHP package repositories and manages the ZendHQ service,
which can be installed, uninstalled, started, stopped, and configured.

## Usage

Using `zendhq` to setup the ZendPHP repositories and install ZendHQ without
configuration is as simple as providing a Zend product license:

```puppet
class { 'zendhq':
  license_source => 'puppet:///modules/<MODULE_NAME>/zend/license',
}
```

Include settings to configure ZendHQ.

```puppet
class { 'zendhq':
  license_source => 'puppet:///modules/<MODULE_NAME>/zend/license',
  settings => {
    'zendhq.daemon_uri' => 'tcp://0.0.0.0:10090',
  },
}
```

Creating a new group and user with read-only permissions using Bolt.

```
$ bolt task run zendhq::group_add group=readonly permissions='r zray,mon,conf,ct,jq' -t zendhq_server
$ bolt task run zendhq::group_print group=readonly -t zendhq_server # verify group creation and permissions
$ bolt task run zendhq::user_add user=readonly_user password=readonly_password group=readonly -t zendhq_server
$ bolt task run zendhq::user_print user=readonly_user -t zendhq_server # verify user creation and permissions
```

## Tasks

Installation of ZendHQ comes with a helpful tool, `zendhqctl`, for managing
groups, users, and their permissions. While this CLI could be called with
Puppet's `exec` functionality, this module comes with tasks for all the
`zendhqctl` commands, making them easy to call with
[PE](https://www.puppet.com/docs/pe/latest/running_tasks_from_the_command_line.html)
or [Bolt](https://www.puppet.com/docs/bolt/latest/bolt_running_tasks).

Please see the reference below for a list of tasks in this module.

## Reference

See [REFERENCE.md](./REFERENCE.md)
