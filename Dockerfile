FROM kalilinux/kali-rolling:latest

RUN apt update && apt upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt install -y htop net-tools dialog firefox-esr inetutils-ping tigervnc-standalone-server \
    tigervnc-xorg-extension \
    tigervnc-viewer

RUN DEBIAN_FRONTEND=noninteractive apt install -y python3-dev python3-pip \
	python3-launchpadlib libseccomp-dev git \
	libtool cmake software-properties-common \
	curl wget openssh-server nano novnc dbus-x11 xvfb \ 
	--fix-missing

RUN DEBIAN_FRONTEND=noninteractive apt install -y xfce4-goodies kali-linux-large kali-desktop-xfce && apt -y full-upgrade --fix-missing

RUN DEBIAN_FRONTEND=noninteractive apt -y autoremove && useradd -m -s /bin/bash -d /home/kalihack kalihack

RUN sed -i "s/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g" /etc/ssh/sshd_config && \
    sed -i "s/off/remote/g" /usr/share/novnc/app/ui.js && \
    echo "kalihack ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
	touch /usr/share/novnc/index.htm

COPY start.sh /start.sh
USER kalihack
WORKDIR /home/kalihack
ENV USER=kalihack
ENV VNC_PASSWORD=YouSHALLnotPASS
ENV SHELL=/bin/bash
EXPOSE 8080
CMD ["/bin/bash", "/start.sh"]