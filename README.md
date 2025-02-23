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
