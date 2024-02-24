FROM nginx:alpine

# simple rootless nginx image with a custom index.html

WORKDIR /usr/share/nginx/html
RUN echo "Hello, World!" > index.html
EXPOSE 80
USER 1000
CMD ["nginx", "-g", "daemon off;"]
