FROM python:3.9.2-alpine3.12

LABEL maintainer="Austin Chen <austin.yhc@gmail.com>"

# https://bit.ly/3snLIvi
# https://bit.ly/3lLIZJh
RUN apk add --no-cache mariadb-connector-c-dev
RUN	apk add --no-cache --virtual .build-deps gcc build-base libc-dev make \
		&& \
    pip install --no-cache-dir \
        fastapi \
        uvicorn[standard] \
        gunicorn \
        sqlalchemy \
        pymysql \
        mysqlclient \
        "pydantic>=1.2.0,<2.0.0" \
		&& \
    apk del .build-deps gcc build-base libc-dev make

COPY sh/start.sh /start.sh
RUN chmod +x /start.sh

COPY gunicorn_conf.py /gunicorn_conf.py

COPY sh/start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

ENV PYTHONPATH=/app
EXPOSE 80

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Uvicorn
CMD ["/start.sh"]
