FROM ubuntu:latest
RUN  apt update -y
RUN apt install wget -y
RUN apt install tar -y
RUN apt install iptables -y
WORKDIR /udpspeeder
RUN wget https://github.com/wangyu-/UDPspeeder/releases/download/20230206.0/speederv2_binaries.tar.gz
RUN wget https://github.com/wangyu-/udp2raw/releases/download/20230206.0/udp2raw_binaries.tar.gz
RUN tar -xvf speederv2_binaries.tar.gz
RUN tar -xvf udp2raw_binaries.tar.gz