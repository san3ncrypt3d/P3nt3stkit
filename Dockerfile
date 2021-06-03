FROM ubuntu:18.04

LABEL maintainer="san3ncrypt3d"

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

WORKDIR /root

RUN apt-get update && \
    apt-get -y upgrade

# Install
RUN apt-get install -y \
    sudo \
    apt-utils \
    locales \
    build-essential \
    gcc-multilib \
    g++-multilib \
    gdb \
    gdb-multiarch \
    python3-dev \
    python3-pip \
    ipython3 \
    man-db \
    make \
    manpages-posix \
    default-jdk \
    net-tools \
    cmake \
    rubygems \
    ruby-dev \
    vim \
    tmux \
    git \
    binwalk \
    strace \
    ltrace \
    autoconf \
    socat \
    netcat \
    nmap \
    wget \
    tcpdump \
    exiftool \
    squashfs-tools \
    unzip \
    upx-ucl \
    man-db \
    manpages-dev \
    libtool-bin \
    awscli \
    bison \
    gperf \
    sqlmap \
    dirb \
    nikto \
    cpanminus \
    python-pycurl \
    python-dnspython \
    libldns-dev \
    ruby-dev \
    apache2 \
    libgmp-dev \
    zlib1g-dev \
    libpcap-dev \
    python \
    python-pip \
    python3 \
    python3-pip \
    perl \
    zsh \
    hydra \
    dnsrecon \
    nano \
    curl \
    powerline \
    fonts-powerline \
    libcurl4-openssl-dev

RUN apt-get -y autoremove
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  pip3 install --upgrade pycurl 
RUN pip3 install wfuzz

RUN mkdir ${HOME}/arsenal && \
    mkdir wordlists


RUN cd ${HOME}/arsenal && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r/ && \
    pip install -r requirements.txt && \
    ln -s ${HOME}/arsenal/Sublist3r/sublist3r.py /usr/local/bin/sublist3r


RUN cd wordlists/ && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git


RUN cd ${HOME}/arsenal && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd massdns/ && \
    make && \
    ln -sf ${HOME}/arsenal/massdns/bin/massdns /usr/local/bin/massdns


RUN cd ${HOME}/arsenal && \
    git clone https://github.com/wpscanteam/wpscan.git && \
    cd wpscan/ && \
    gem install bundler && bundle install --without test && \
    gem install wpscan


RUN cd ${HOME}/arsenal && \
    git clone https://github.com/robertdavidgraham/masscan.git && \
    cd masscan && \
    make && \
    ln -sf ${HOME}/arsenal/masscan/bin/masscan /usr/local/bin/masscan

RUN cd ${HOME}/arsenal && \
    git clone https://github.com/infosec-au/altdns.git && \
    cd altdns && \
    pip install -r requirements.txt && \
    chmod +x setup.py && \
    python setup.py install

RUN cd ${HOME}/arsenal && \
    git clone https://github.com/tomdev/teh_s3_bucketeers.git && \
    cd teh_s3_bucketeers && \
    chmod +x bucketeer.sh && \
    ln -sf ${HOME}/arsenal/teh_s3_bucketeers/bucketeer.sh /usr/local/bin/bucketeer

RUN cd ${HOME}/arsenal && \
    git clone https://github.com/lanmaster53/recon-ng.git && \
    cd recon-ng && \
    pip3 install -r REQUIREMENTS && \
    chmod +x recon-ng && \
    ln -sf ${HOME}/arsenal/recon-ng/recon-ng /usr/local/bin/recon-ng

RUN cd ${HOME}/arsenal && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && \
    pip3 install -r requirements.txt && \
    chmod +x xsstrike.py && \
    ln -sf ${HOME}/arsenal/XSStrike/xsstrike.py /usr/local/bin/xsstrike


RUN cd ${HOME}/arsenal && \
    git clone https://github.com/AlexisAhmed/theHarvester.git && \
    cd theHarvester && \
    python3 -m pip install -r requirements.txt && \
    chmod +x theHarvester.py && \
    ln -sf ${HOME}/arsenal/theHarvester/theHarvester.py /usr/local/bin/theharvester


RUN wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz && \
    tar -xvf go1.16.4.linux-amd64.tar.gz && \
    rm -rf ${HOME}/go1.16.4.linux-amd64.tar.gz && \
    mv go /usr/local

ENV GOROOT /usr/local/go
ENV GOPATH /$HOME/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}

RUN cd ${HOME}/arsenal && \
    git clone https://github.com/OJ/gobuster.git && \
    cd gobuster && \
    go get && go install



ENTRYPOINT ["/bin/bash","-l","-c"]
