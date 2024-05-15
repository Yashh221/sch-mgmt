# Use the official Node.js image as the base image
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application to the working directory
COPY . .

# Build the Vite application
RUN npm run build

# Stage 2: Serve the built files using a simple server
FROM node:16 AS production

# Install a simple web server to serve the static files
RUN npm install -g serve

# Copy the built files from the previous stage
COPY --from=build /app/dist /app/dist

# Set the working directory
WORKDIR /app

# Specify the command to run the application
CMD ["serve", "-s", "dist", "-l", "5000"]

# Expose port 5000
EXPOSE 5000
