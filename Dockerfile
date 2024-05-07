FROM node:16-alpine as builder
WORKDIR '/app'
# no need for volumes in production: they were only needed to allow changing
# code to update in real time for efficient development
COPY . .
# the build folder will be /app/build
RUN npm run build

# The from command denotes the "second block" of the build
FROM nginx
# Copy ONLY the /app/build folder from the builder phase to
# /usr/share/nginx/html is the standard static content folder for nginx
COPY --from=builder /app/dist /usr/share/nginx/html
# The nginx container starts automatically so no command is needed