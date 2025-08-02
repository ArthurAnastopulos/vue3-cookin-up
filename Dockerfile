FROM node:22.16-alpine AS builder

WORKDIR /app

COPY package*.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build


FROM node:22.16-alpine AS runtime

WORKDIR /app
RUN yarn global add serve
COPY --from=builder /app/dist ./dist

EXPOSE 5173

CMD ["serve", "-s", "dist", "-l", "5173"]
