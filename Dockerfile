FROM ubuntu:latest

ARG IP_V4
ENV IP_V4=$IP_V4

ARG PROTOCOL
ENV PROTOCOL=$PROTOCOL


RUN  apt update
RUN  apt install -y wget

WORKDIR /ovpn
COPY ./ovpn-install.sh .
COPY ./ovpn-add-client.sh .
RUN ls
RUN chmod +x ./ovpn-install.sh 
RUN chmod +x ./ovpn-add-client.sh 


ENTRYPOINT [ "bash", "-c", "IP_V4=$IP_V4 PROTOCOL=$PROTOCOL ./ovpn-install.sh" ]