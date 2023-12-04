# Stage 1: Build Angular app
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Install Angular CLI
RUN npm install -g @angular/cli@14.0.2

# Copy the application code
COPY . /app

# update the npm 
RUN npm update

# Install dependencies
RUN npm install

# Build the Angular app
RUN ng build

# Stage 2: Use Nginx to serve the app
FROM nginx:alpine

# Copy the Angular build from the build stage to the Nginx web server directory
COPY --from=build /app/dist/angular-social-network /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to run the Nginx server
CMD ["nginx", "-g", "daemon off;"]
