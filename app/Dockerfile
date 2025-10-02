# Use Node.js LTS base image
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy application code
COPY . .

# Expose app port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]

