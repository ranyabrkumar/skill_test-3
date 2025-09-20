FROM node:18-alpine
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install --production
COPY . .
ENV PORT=3004
ENV MESSAGE="Order Service Running"

EXPOSE 3004

CMD ["node", "app.js"]
