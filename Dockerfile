FROM node:lts-alpine
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm ci --omit=dev
COPY db.json ./
EXPOSE 3000
ENTRYPOINT [ "npm", "run", "start" ]
