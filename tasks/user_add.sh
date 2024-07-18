#!/usr/bin/env bash

[[ -z "$PT_group" ]] && group='' || group="--group $PT_group"
[ "$PT_disable" = true ] && disable='--disable' || disable=''

/opt/zend/zendphp/bin/zendhqctl access user add $PT_user --comment "$PT_comment" --password $PT_password $group $disable
