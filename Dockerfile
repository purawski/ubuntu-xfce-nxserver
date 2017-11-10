FROM ubuntu:17.10
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --force-yes --force-yes\
       curl gnupg \
    && curl -O https://dl-ssl.google.com/linux/linux_signing_key.pub \
    && apt-key add linux_signing_key.pub \
    && rm linux_signing_key.pub \
#RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg 
#RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg 
#RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list 
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    #&& echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list.d/linuxmint.list \
    #&& echo "deb http://mozilla.debian.net/ jessie-backports firefox-release" >> /etc/apt/sources.list.d/debian-mozilla.list \
    #&& curl -O http://mozilla.debian.net/pkg-mozilla-archive-keyring_1.1_all.deb \
    #&& dpkg -i pkg-mozilla-archive-keyring_1.1_all.deb \
    #&& rm pkg-mozilla-archive-keyring_1.1_all.deb \
    && apt-get update \
    && apt-get install -y --force-yes --force-yes\
        sudo \
        bash-completion \
        vim git \
        cups \
        xfce4 \
        xfce4-whiskermenu-plugin \
        terminator \
        google-chrome-stable \
        firefox \
        pelican \
        wget \
        remmina \
#        code \
    && rm /etc/apt/sources.list.d/google.list 
RUN curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o code_1.18.0-1510145176_amd64.deb 
RUN dpkg -i code_1.18.0-1510145176_amd64.deb \
    && rm code_1.18.0-1510145176_amd64.deb \
    && curl http://download.nomachine.com/download/5.3/Linux/nomachine_5.3.12_10_amd64.deb -o /nomachine.deb \
    && dpkg -i /nomachine.deb \
    && rm /nomachine.deb \
    && mkdir /root/.config \
    && apt-get autoremove \
    && apt-get autoclean 

EXPOSE 4000

#COPY xfce4 /root/.config/xfce4
COPY scripts /scripts

ENTRYPOINT ["/scripts/init.sh"]
