# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "mattermost/app/map.jinja" import app with context %}

include:
  - mattermost.app.install

{%- for dir in app.directory %}
mattermost-app-{{ dir }}-dir:
  file.directory:
    - name: {{ app.directory[dir] }}
{%- endfor %}

mattermost-app-container:
  dockerng.running:
    - name: {{ app.name }}
    - image: {{ app.image }}:{{ app.branch }}
    - binds:
      - {{ app.directory["config"] }}:/mattermost/config:rw
      - {{ app.directory["data"] }}:/mattermost/data:rw
      - {{ app.directory["logs"] }}:/mattermost/logs:rw
    - port_bindings:
      - {{ app.port }}:80
    - environment:
      - DB_HOST: {{ app.environment["DB_HOST"] }}
      - DB_PORT_NUMBER: {{ app.environment["DB_PORT_NUMBER"]|yaml_squote }}
      - MM_DBNAME: {{ app.environment["MM_DBNAME"] }}
      - MM_USERNAME: {{ app.environment["MM_USERNAME"] }}
      - MM_PASSWORD: {{ app.environment["MM_PASSWORD"] }}
    - require:
      - dockerng: mattermost-app-image
