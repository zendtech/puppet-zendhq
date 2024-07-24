#!/usr/bin/env bash

[[ -z "$PT_permissions" ]] && permissions='' || permissions="--permissions $PT_permissions"

/opt/zend/zendphp/bin/zendhqctl access group add $PT_group --comment "$PT_comment" $permissions
