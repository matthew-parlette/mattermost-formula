# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "mattermost/app/map.jinja" import app with context %}

mattermost-app-image:
  dockerng.image_present:
    - name: {{ app.image }}:{{ app.branch }}
    - force: True
