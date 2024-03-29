FROM node:18-alpine as build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:18-alpine

WORKDIR /app

COPY --from=build-stage /app/.output ./app/.output

EXPOSE 3000

CMD [ "node", ".output/server/index.mjs" ]