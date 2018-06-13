FROM python:3.6.4-alpine3.7

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 0

# copy app
ADD . /application
WORKDIR /application

# install pip packages
RUN sh_scripts/install.sh

# app runs on 8000 port
EXPOSE 8000

# run app
ENTRYPOINT ["sh", "sh_scripts/start.sh"]
