# Use the official Node.js base image
FROM nginx:latest

# Set the working directory in the container
COPY ./dist/muffeez-portfolio /usr/share/nginx/html

# Copy the package.json and package-lock.json (or yarn.lock) to the working directory
COPY package.json package-lock.json* yarn.lock* ./

# Install dependencies
RUN npm config set strict-ssl false
RUN npm install --registry=https://registry.npmjs.org/ --force
RUN npm install --force

# Copy the entire project to the container
COPY . .

# Set the ownership of the working directory to the non-root user
RUN chown -R node:node /usr/src/app

# Switch to the non-root user
USER node

# Build the Gatsby application
RUN npm run build

# Expose the Gatsby development server port (if needed)
EXPOSE 80

# Start the Gatsby development server (or any other desired script)
CMD ["npm", "start"]

