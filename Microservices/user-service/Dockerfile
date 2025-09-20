FROM node:18-alpine
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install --production
COPY . .
ENV PORT=3001
ENV MESSAGE="user Service Running"

EXPOSE 3001

CMD ["node", "app.js"]
