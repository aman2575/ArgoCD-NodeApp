# Use a base image with Node.js
FROM node:14-alpine as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the application code
COPY . .

# Build the application
#RUN npm run build

# Create a production image
FROM node:14-alpine

# Set the working directory
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app .

# Expose the port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]