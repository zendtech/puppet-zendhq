#!/usr/bin/env bash

[[ -z "$PT_permission_mask" ]] && permissions='' || permissions="--permissions $PT_permission_mask"

/opt/zend/zendphp/bin/zendhqctl access group add $PT_group --comment "$PT_comment" $permissions
