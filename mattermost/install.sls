# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "mattermost/map.jinja" import mattermost with context %}

mattermost-image:
  dockerng.image_present:
    - name: {{ mattermost.image }}:{{ mattermost.branch }}
    - force: True
