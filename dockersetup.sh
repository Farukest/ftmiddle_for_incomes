CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
        touch $CONTAINER_ALREADY_STARTED
        echo "-- First container startup --"
        echo " {"\
         "  \"gateway_conf\": {" \
         "      \"gateway_ID\": \"${gateway_ID}\"," \
         "      \"server_address\": \"${server_address}\"," \
         "      \"serv_port_up\": ${serv_port_up}," \
         "      \"serv_port_down\": ${serv_port_down}" \
         "    }"\
         "  }" > /home/ftmiddle/configs/config.json

        echo "ftmiddle_ENVs=\"${ftmiddle_ENVs}\"" > /home/ftmiddle/ftmiddle.conf
        cat /home/ftmiddle/configs/config.json && cat /home/ftmiddle/ftmiddle.conf
else
        echo "-- Not first container startup --"
fi
python3 /home/ftmiddle/gateways2miners.py -d -p ${ftmiddle_port} -c /home/ftmiddle/configs/
