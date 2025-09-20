FROM node:18-alpine
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install --production
COPY . .
ENV PORT=3000
ENV MESSAGE="frontend Service Running"

EXPOSE 3000

CMD ["node", "app.js"]
