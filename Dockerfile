FROM node:latest as build

WORKDIR /usr/src/app

COPY . .
RUN npm install -g @angular/cli

RUN npm install

RUN npm run build

# Stage 2: Serve app with nginx server

FROM nginx:latest

COPY --from=build /usr/src/app/dist/angular-social-network /usr/share/nginx/html

EXPOSE 80