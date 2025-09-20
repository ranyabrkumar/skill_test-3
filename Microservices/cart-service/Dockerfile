FROM node:18-alpine
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install --production
COPY . .
ENV PORT=3003
ENV MESSAGE="Cart Service Running"

EXPOSE 3003

CMD ["node", "app.js"]
