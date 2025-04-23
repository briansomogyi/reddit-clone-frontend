# Use Node.js official image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock files
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the entire frontend code
COPY . .

# Build the frontend
RUN yarn build

# Use nginx for serving the build
FROM nginx:stable-alpine
COPY --from=0 /app/dist /usr/share/nginx/html

# Expose the port nginx serves on
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
