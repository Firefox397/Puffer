
FROM ubuntu:latest

RUN docker pull node:latest
RUN docker pull python:latest
RUN docker pull pufferpanel/pufferpanel

RUN docker run -d --name pufferpanel -p 8080:8080 pufferpanel/pufferpanel

RUN sleep 10

RUN docker exec -it pufferpanel /pufferpanel/pufferpanel user add Wesley adm@adm.com nnnnnnnn all

EXPOSE 8080

CMD ["docker", "exec", "-it", "pufferpanel", "/pufferpanel/pufferpanel"]
