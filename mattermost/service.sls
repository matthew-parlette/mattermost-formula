# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "mattermost/map.jinja" import mattermost with context %}

include:
  - mattermost.install

mattermost-file:
  file.touch:
    - name: {{ mattermost.filename }}

mattermost-dir:
  file.directory:
    - name: {{ mattermost.directory }}

mattermost-container:
  dockerng.running:
    - name: {{ mattermost.name }}
    - image: {{ mattermost.image }}:{{ mattermost.branch }}
    - binds:
      - {{ mattermost.directory }}:/path/on/container:rw
    - port_bindings:
      - {{ mattermost.port }}:3000
    {%- if mattermost['environment'] is defined %}
    - environment:
      {%- for env, value in mattermost.environment.items() %}
      - {{ env }}: {{ value|yaml_squote }}
      {%- endfor %}
    {%- endif %}
    - require:
      - dockerng: mattermost-image
