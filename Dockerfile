FROM python:3.6-slim

WORKDIR /app
ADD . /app/
ENV PYTHONPATH="usr/local/lib/python3.6/site-packages" PATH="usr/local/bin:${PATH}"
EXPOSE 8000
CMD gunicorn \
  --workers=2 \
  --worker-class="egg:meinheld#gunicorn_worker" \
  --bind=0.0.0.0
  app:app
