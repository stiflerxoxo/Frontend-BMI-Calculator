# DockerFile for dockerhub

# FROM node:16-alpine as build

# WORKDIR /app

# COPY package*.json ./

# RUN npm install

# COPY . .

# RUN npm run build

# RUN ls -l && ls -l build


# ### STAGE 2 ###

# FROM nginx:alpine

# COPY --from=build /app/build /usr/share/nginx/html

# COPY nginx.conf /etc/nginx/conf.d/default.conf

# CMD ["nginx", "-g", "daemon off;"]


########## Dockerfile for ECR ##########

# ---- Stage 1: Build React App ----
FROM 265020546803.dkr.ecr.eu-north-1.amazonaws.com/node:16-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install
# RUN npm install react-icons

COPY . .
RUN npm run build
# RUN SKIP_PREFLIGHT_CHECK=true npm run build



# ---- Stage 2: Serve with Nginx ----
FROM 265020546803.dkr.ecr.eu-north-1.amazonaws.com/nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
