# Use the official Node.js image from Docker Hub
FROM node:14

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application files to the container image
COPY . .

# Run the web service on container startup
CMD [ "node", "app.js" ]

# Inform Docker that the container listens on port 3000
EXPOSE 3000

