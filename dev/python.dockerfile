FROM python:3.6

RUN apt-get update && apt-get install -y entr && rm -rf /var/lib/apt/lists/*
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 \
  && chmod +x /usr/local/bin/dumb-init
WORKDIR /app
ADD requirements.txt /app
RUN pip install -r requirements.txt
CMD ["dumb-init", "gunicorn", "--workers=2", "--worker-class=egg:meinheld#gunicorn_worker", "--bind=0.0.0.0", "app:app"]
