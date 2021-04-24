# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20210424
# uvicorn myapp.main:app --reload --port ${SERVICE_CONTAINER_PORT}
uvicorn ${SERVICE}.main:app --reload --port ${SERVICE_CONTAINER_PORT}