FROM kylemanna/openvpn

ARG OVPN_URL
ENV OVPN_URL=${OVPN_URL}
COPY ./ovpn-add-client.sh /ovpn-add-client.sh
RUN chmod +x /ovpn-add-client.sh
RUN ovpn_genconfig -u $OVPN_URL && \
    echo -e "\n" | ovpn_initpki nopass
RUN mv /etc/openvpn /etc/openvpn-back

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
