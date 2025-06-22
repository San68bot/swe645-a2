#
# Name: Sanjay Mohan Kumar
# File: agent.Dockerfile
# Purpose: Creates a custom agent image with AWS CLI and kubectl installed.
#

FROM amazon/aws-cli:latest

USER root

RUN yum install -y curl && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl