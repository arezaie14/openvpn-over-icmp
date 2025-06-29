new_client () {
    mkdir -p /etc/openvpn/confs
    ovpn_getclient $client > /etc/openvpn/confs/"$client".ovpn
}

echo "OpenVPN is already installed."
echo
echo "Select an option:"
echo "   1) Add a new client"
echo "   2) Revoke an existing client"
echo "   3) Number Of Client"
echo "   4) Exit"
read -p "Option: " option
until [[ "$option" =~ ^[1-5]$ ]]; do
    echo "$option: invalid selection."
    read -p "Option: " option
done
case "$option" in
    1)
        echo
        echo "Provide a name for the client:"
        read -p "Name: " unsanitized_client
        client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client")
        while [[ -z "$client" || -e /etc/openvpn/server/easy-rsa/pki/issued/"$client".crt ]]; do
            echo "$client: invalid name."
            read -p "Name: " unsanitized_client
            client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client")
        done
        easyrsa --days=3650 build-client-full "$client" nopass
        new_client
        echo
        echo "$client added. Configuration available in:" ~/"$client.ovpn"
        exit
    ;;
    2)
        number_of_clients=$(tail -n +2 /etc/openvpn/pki/index.txt | grep -c "^V")
        if [[ "$number_of_clients" = 0 ]]; then
            echo
            echo "There are no existing clients!"
            exit
        fi
        echo
        echo "Select the client to revoke:"
        tail -n +2 /etc/openvpn/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') '
        read -p "Client: " client_number
        until [[ "$client_number" =~ ^[0-9]+$ && "$client_number" -le "$number_of_clients" ]]; do
            echo "$client_number: invalid selection."
            read -p "Client: " client_number
        done
        client=$(tail -n +2 /etc/openvpn/pki/index.txt | grep "^V" | cut -d '=' -f 2 | sed -n "$client_number"p)
        echo
        read -p "Confirm $client revocation? [y/N]: " revoke
        until [[ "$revoke" =~ ^[yYnN]*$ ]]; do
            echo "$revoke: invalid selection."
            read -p "Confirm $client revocation? [y/N]: " revoke
        done
        if [[ "$revoke" =~ ^[yY]$ ]]; then
            easyrsa --batch revoke "$client"
            easyrsa --batch --days=3650 gen-crl
            easyrsa gen-crl
            rm -rf /etc/openvpn/confs/"$client".ovpn
            kill -HUP 1
            echo
            echo "$client revoked!"
        else
            echo
            echo "$client revocation aborted!"
        fi
        exit
    ;;
    3)
        echo
        echo "Enter number of client:"
        read -p "Number: " unsanitized_client
        client_count=$(sed 's/[^0123456789]/_/g' <<< "$unsanitized_client")
        current_time=$(date +"%Y%m%d%H%M%S_")
        for ((i = 1; i <= client_count; i++)); do
            next_client_number=$((last_client_number + i))
            client="${current_time}${next_client_number}"
	        easyrsa  --days=3650 build-client-full "$client" nopass
            new_client
            echo
            echo "$client added. Configuration available in:" ~/"$client.ovpn"
        done
        exit
    ;;
    4)
        exit
    ;;
esac
