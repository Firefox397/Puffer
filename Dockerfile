
FROM docker:latest

RUN pkg update -y && pkg install -y \
  docker \
  nodejs \
  unzip \
  curl \
  python3


RUN dockerd &


RUN docker pull pufferpanel/pufferpanel

RUN docker run -d --name pufferpanel -p 8080:8080 pufferpanel/pufferpanel

RUN sleep 10


RUN curl -X POST \
  http://localhost:8080/api/v1/users \
  -H 'Content-Type: application/json' \
  -u 'admin:admin' \
  -d '{"name": "Wesley", "email": "adm@adm.com", "password": "nnnnnnnn", "permissions": "all"}'


EXPOSE 8080

CMD ["docker", "exec", "-d", "pufferpanel", "/usr/bin/pufferpanel"]
