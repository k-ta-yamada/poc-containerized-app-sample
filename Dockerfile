# Rate Limit への対応として public.ecr.aws からの取得に変更とする
FROM public.ecr.aws/docker/library/node:22-alpine
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm ci --omit=dev
COPY db.json ./
EXPOSE 3000
ENTRYPOINT [ "npm", "run", "start" ]
