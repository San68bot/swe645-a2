#
# Sanjay Mohan Kumar
# File: Dockerfile
# File Purpose: This file defines the steps to build a Docker image

FROM nginx:alpine

LABEL maintainer="san68bot@gmail.com"

COPY index.html /usr/share/nginx/html/index.html
COPY survey.html /usr/share/nginx/html/survey.html
COPY assets /usr/share/nginx/html/assets/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]