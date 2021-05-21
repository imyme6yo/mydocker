#!/bin/bash
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210424
# @UPDATE: 20210425
# uvicorn myapp.main:app --reload --port ${SERVICE_CONTAINER_PORT}
uvicorn ${SERVICE}.main:app --reload --host 0.0.0.0 --port ${SERVICE_CONTAINER_PORT}