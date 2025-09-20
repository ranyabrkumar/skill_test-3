FROM node:18-alpine
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install --production
COPY . .
ENV PORT=3002
ENV MESSAGE="Product Service Running"

EXPOSE 3002

CMD ["node", "app.js"]
