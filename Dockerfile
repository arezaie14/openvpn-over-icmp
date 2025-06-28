FROM ubuntu:latest

ARG IP_V4
ENV OVPN_IP=$IP_V4

ARG PROTOCOL
ENV PROTOCOL=$PROTOCOL


RUN  apt update
RUN  apt install -y wget

WORKDIR /ovpn
COPY ./ovpn-install.sh ./ovpn-install.sh.template
COPY ./ovpn-add-client.sh .

RUN sed -e "s|{OVPN_IP}|${OVPN_IP}|g"  -e "s|{PROTOCOL}|${PROTOCOL}|g" ./ovpn-install.sh.template > ./ovpn-install.sh

RUN chmod +x ./ovpn-install.sh 
RUN chmod +x ./ovpn-add-client.sh 


ENTRYPOINT [ "bash", "-c", "./ovpn-install.sh" ]