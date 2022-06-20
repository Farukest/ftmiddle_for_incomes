#https://github.com/farukest/ftmiddle.git

FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
ENV container docker
ENV PATH="/usr/bin:${PATH}"

### Envrionment config
ENV HOME=/
WORKDIR $HOME

# Specify Ftmiddle Environment Variables
ENV ftmiddle_port=1681
ENV ftmiddle_tx_adjust='--tx-adjust 0'
ENV ftmiddle_rx_adjust='--rx-adjust 0'
ENV ftmiddle_ENVs="${ftmiddle_tx_adjust} ${ftmiddle_rx_adjust}"

# Service Virtual Environment Variables
ENV gateway_ID=AA555A0000000000
ENV server_address=localhost
ENV serv_port_up=1680
ENV serv_port_down=1680

# Echo Path
RUN echo ${PATH}

# Update Packages
RUN apt-get update && apt-get install -y apt-utils && apt-get -y -f -m --show-progress full-upgrade

# Install Supporting Software
RUN apt-get install -y git cmake make htop wget python3 python3-pip systemctl gcc curl gpg
# Fix Python3 and Python3-pip
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools

# Install Ft-Middle
RUN git clone https://github.com/Farukest/ftmiddle.git
RUN cd /ftmiddle && make install
#RUN rm /home/ftmiddle/configs/*.example > /dev/null

#SETUP MYSELF
#RUN cd /ftmiddle/ && chmod +x ./dockersetup.sh
#RUN cd /ftmiddle/ && cat ./dockersetup.sh
#CMD ["/bin/bash", "/ftmiddle/dockersetup.sh"]

#SETUP is FIXED already
RUN cd /ftmiddle/ && chmod +x ./dockersetupfixconfig.sh
RUN cd /ftmiddle/ && cat ./dockersetupfixconfig.sh
CMD ["/bin/bash", "/ftmiddle/dockersetupfixconfig.sh"]