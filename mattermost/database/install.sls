# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "mattermost/database/map.jinja" import database with context %}

mattermost-database-image:
  dockerng.image_present:
    - name: {{ database.image }}:{{ database.branch }}
    - force: True
