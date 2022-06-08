
# Run ubuntu and open bash (--it -> iterative)
docker run ubuntu --it bash

docker image ls # list all images
docker inspect [IMAGE ID] # show image´s details
docker history [IMAGE ID] # show image´s layers

docker ps # all containers running
docker container ls

docker ps -a # all containers
docker container ls -a

docker stop $(docker ps -q) 
docker rm $(docker ps -aq)

docker rm $(docker ps -aq) --force # Stop and Remove

docker container stop $(docker container ls -q) 
docker container rm $(docker container ls -aq)

docker rmi $(docker image ls -q)

# Run container and bind port (-d terminal detached)
docker run -d -p 8080:3000 luisfelipesouza/app-node:1.0
docker run -d -p 9090:6000 luisfelipesouza/app-node:1.2

# Show container's port
docker port

# Dockerfile build
docker build -t luisfelipesouza/app-node:1.2 .

# Dockerhub login & push (image)
docker login -u luisfelipesouza
docker push luisfelipesouza/app-node:1.0
docker pull luisfelipesouza/app-node:1.0

docker image ls
docker rmi $(docker image ls -q)


# User-Managed (Persistido e gerenciado caminho definido)
# Vinculo em nosso host e o container
docker run -it -v D:\alura\docker\volume-docker:/app ubuntu bash
docker run -it --mount type=bind,source=D:\alura\docker\volume-docker,target=/app ubuntu bash

# Docker-Managed (Persistido e gerenciado pelo docker)
# Recommended
docker volume ls
docker volume create meu-volume

docker volume rm $(docker volume ls -q) --force

docker run -it -v meu-volume:/app ubuntu bash
docker run -it --mount source=meu-volume,target=/app ubuntu bash

# Temporário (Persistido na memórida do Container)
# Exemplo: Conteúdo sensível
docker run -it --mount type=tmpfs,target=/app ubuntu bash


# Networking
docker network ls
docker network create --driver bridge my-network
# user-defined bridger networks make dns resolution

docker run -it --name ubuntu1 --network my-network ubuntu bash
docker run -it --name pong --network my-network ubuntu bash

# comunicação entre aplicações
docker run -d --network my-network  --name meu-mongo mongo:4.4.6
docker run -d -p 3000:3000 --network my-network --name alurabooks aluradocker/alura-books:1.0


# Compose
docker-compose up
docker-compose up -d

docker-compose down

docker-compose ps

docker-compose start
docker-compose stop