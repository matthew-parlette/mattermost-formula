# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "mattermost/database/map.jinja" import database with context %}

include:
  - mattermost.database.install

mattermost-database-dir:
  file.directory:
    - name: {{ database.directory }}

mattermost-database-container:
  dockerng.running:
    - name: {{ database.name }}
    - image: {{ database.image }}:{{ database.branch }}
    - binds:
      - {{ database.directory }}:/var/lib/postgresql/data:rw
    - port_bindings:
      - {{ database.port }}:5432
    - environment:
      - POSTGRES_DB: {{ database.environment["POSTGRES_DB"] }}
      - POSTGRES_USER: {{ database.environment["POSTGRES_USER"] }}
      - POSTGRES_PASSWORD: {{ database.environment["POSTGRES_PASSWORD"] }}
    - require:
      - dockerng: mattermost-database-image
