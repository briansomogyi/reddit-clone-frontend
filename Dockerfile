# Use Node.js official image
FROM node:23-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock files
COPY package.json yarn.lock ./
COPY --from=dependencies /root/.yarn /root/.yarn

# Install dependencies
RUN corepack enable yarn
RUN corepack install -g yarn@4.6.0
RUN yarn -v
RUN yarn cache clean --all
RUN yarn install --immutable
RUN yarn bin

# Copy the entire frontend code
COPY . .

# Build the frontend
RUN yarn dev --host

# Use nginx for serving the build
FROM nginx:stable-alpine
COPY --from=0 /app/dist /usr/share/nginx/html

# Expose the port nginx serves on
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
