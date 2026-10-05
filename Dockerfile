# How should my application become a Docker image?

# Install dependencies:
# =======================
FROM node:22-alpine AS deps

WORKDIR /app

COPY package*.json ./
RUN npm ci
# =======================

# Create a build of the application:
# =======================
FROM node:22-alpine AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build
# =======================

# Only copy the necessary files to run the application:
# =======================
FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=10000
ENV HOSTNAME=0.0.0.0

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 10000

CMD ["node", "server.js"]
# =======================