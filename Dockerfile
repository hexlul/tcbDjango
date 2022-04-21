FROM registry.cn-zhangjiakou.aliyuncs.com/dvadmin-pro/node12-base-web:latest
WORKDIR /web/
COPY web/. .
RUN npm install --registry=https://registry.npm.taobao.org
RUN npm run build

FROM nginx:alpine
COPY ./docker_env/nginx/my.conf /etc/nginx/conf.d/my.conf
COPY --from=0 /web/dist /usr/share/nginx/html

FROM registry.cn-zhangjiakou.aliyuncs.com/dvadmin-pro/python38-base-backend:latest
WORKDIR /backend
COPY ./backend/ .
RUN awk 'BEGIN { cmd="cp -i ./conf/env.example.py   ./conf/env.py "; print "n" |cmd; }'
RUN python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt
CMD ["daphne","-b","0.0.0.0","-p","8000","application.asgi:application"]
