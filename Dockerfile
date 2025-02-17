# Build with pnpm
FROM docker.io/gplane/pnpm:node21-alpine AS builder

WORKDIR /ohmycv

COPY . .

# builds to /ohmycv/site/.output/public
RUN pnpm install --frozen-lockfile && pnpm release

# Serve via nginx
FROM docker.io/nginx:alpine

COPY --from=builder /ohmycv/site/.output/public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
