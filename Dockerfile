# Base
FROM node:20-alpine AS base

ARG PORT=3000
ARG NODE_ENV=production

WORKDIR /src

# Build
FROM base AS build

COPY --link package.json package-lock.json .
RUN npm install --production=false

COPY --link . .

RUN npm run build
RUN npm prune


# Run
FROM base

ENV PORT=$PORT

COPY --from=build /src/.output /src/.output

CMD [ "node", ".output/server/index.mjs" ]
