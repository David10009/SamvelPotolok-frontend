# Этап сборки
FROM node:22-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

# Убираем VITE_API_URL — в продакшене nginx проксирует запросы
ENV VITE_API_URL=""
RUN npm run build

# Этап раздачи
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]