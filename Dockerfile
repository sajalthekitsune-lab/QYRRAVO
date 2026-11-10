FROM node:22-slim
WORKDIR /app
COPY . .
ENV NODE_ENV=production PORT=3000 DATABASE_PATH=/data/qyrravo.db UPLOAD_DIR=/data/uploads TRUST_PROXY=1
VOLUME /data
EXPOSE 3000
CMD ["node", "--disable-warning=ExperimentalWarning", "server/index.js"]
