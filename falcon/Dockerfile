FROM python:3.7-alpine
RUN apk add postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    pip install --no-cache-dir cython && \
    pip install --no-binary :all: falcon && \
    pip install --no-cache-dir gunicorn && \
    pip install --no-cache-dir psycopg2 && \
    pip install --no-cache-dir peewee && \
    pip install --no-cache-dir py-bcrypt && \
    pip install --no-cache-dir pyjwt && \
    apk --purge del .build-deps gcc musl-dev
WORKDIR /app
COPY app .
