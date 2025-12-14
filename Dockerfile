#build stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

#production stage
FROM node:18-alpine

WORKDIR /app

#here creating non root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/package.json ./package.json

USER appuser

EXPOSE 5000

CMD ["npm", "start"]