# poc-containerized-app-sample

## git init

```sh
echo "# $(basename $(pwd))" > README.md
gibo dump node macos > .gitignore

git init
git add .
git ci -m init
```

## npm init & setup json server

```sh
npm init -y
npm install json-server

cat << EOF > db.json
{
  "todos": [
    { "id": 1, "title": "Est fugiat irure in irure elit magna.", "done": true },
    { "id": 2, "title": "Pariatur sint eiusmod nisi officia mollit nisi non.", "done": false }
  ]
}
EOF

npm pkg delete scripts.test
npm pkg set scripts.start="json-server db.json"

npm start

git add .
git ci -m "setup mock app by json-server"
```

## Containerize Application

### Create Dockerfile & .dockerignore

- ref: Part 1: Containerize an application | Docker Docs
  - <https://docs.docker.com/get-started/workshop/02_our_app/>
- ref: docker/getting-started-app: A simple application for the getting started guide in Docker's documentation
  - <https://github.com/docker/getting-started-app/tree/main>

```sh
cat << EOF > Dockerfile
FROM node:lts-alpine
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm ci --omit=dev
COPY db.json ./
EXPOSE 3000
ENTRYPOINT [ "npm", "run", "start" ]
EOF

cat << EOF > .dockerignore
node_modules
Dockerfile
EOF
```

### docker build & docker run

```sh
# clean up
docker image ls
docker image rm -f todo-app

docker build -t todo-app .

docker image ls
```

```sh
docker run -d --rm -p 3000:3000 --name todo-app todo-app
docker ps

curl http://localhost:3000/todos

# clean up
docker stop todo-app
docker ps
```
