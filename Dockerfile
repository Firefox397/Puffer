
Imagem base
FROM docker:latest

Instalar dependências
RUN pkg update -y && pkg install -y \
  docker \
  nodejs \
  unzip \
  curl \
  python3

Iniciar Docker
RUN dockerd &

Baixar imagem PufferPanel
RUN docker pull pufferpanel/pufferpanel

Criar container PufferPanel
RUN docker run -d --name pufferpanel -p 8080:8080 pufferpanel/pufferpanel

Aguardar 10 segundos para inicialização
RUN sleep 10

Criar usuário administrador
RUN curl -X POST \
  http://localhost:8080/api/v1/users \
  -H 'Content-Type: application/json' \
  -u 'admin:admin' \
  -d '{"name": "Wesley", "email": "adm@adm.com", "password": "nnnnnnnn", "permissions": "all"}'

Expor porta
EXPOSE 8080

Comando padrão
CMD ["docker", "exec", "-d", "pufferpanel", "/usr/bin/pufferpanel"]
