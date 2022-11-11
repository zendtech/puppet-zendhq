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

## Reference

See [REFERENCE.md](./REFERENCE.md)
