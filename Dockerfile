

FROM python:3.8-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add bash bash-doc bash-completion git freetds-dev jpeg-dev linux-headers mysql-client mariadb-dev build-base libffi-dev openssl-dev zlib-dev bzip2-dev pcre-dev ncurses-dev readline-dev tk-dev postgresql-dev
WORKDIR /backend
COPY ./backend/requirements.txt /
COPY ./docker_env/requirements-all.txt /
RUN python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ -r /requirements.txt

FROM registry.cn-zhangjiakou.aliyuncs.com/dvadmin-pro/python38-base-backend:latest
WORKDIR /backend
COPY ./backend/ .
RUN awk 'BEGIN { cmd="cp -i  ./conf/env.py "; print "n" |cmd; }'
RUN python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt
CMD ["daphne","-b","0.0.0.0","-p","8000","application.asgi:application"]

FROM nginx:alpine
COPY ./docker_env/nginx/my.conf /etc/nginx/conf.d/my.conf
COPY --from=0 /web/dist /usr/share/nginx/html

FROM node:14-alpine
COPY ./web/package.json /
RUN npm install --registry=https://registry.npm.taobao.org

FROM registry.cn-zhangjiakou.aliyuncs.com/dvadmin-pro/node12-base-web:latest
WORKDIR /web/
COPY web/. .
RUN npm install --registry=https://registry.npm.taobao.org
RUN npm run build




