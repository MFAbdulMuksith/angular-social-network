# Install Node.js and npm
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Install Angular CLI
RUN npm install -g @angular/cli@14.0.2

# Copy the application code
COPY . /app

# Install dependencies
RUN npm install

# Build the Angular app
RUN ng build 

# Use Nginx to serve the app
FROM nginx:alpine

# Copy the Angular build from the node image to the Nginx web server directory
COPY --from=build /app/dist/angular-social-network /usr/share/nginx/html

EXPOSE 80

# Command to run the Nginx server
CMD ["nginx", "-g", "daemon off;"]
