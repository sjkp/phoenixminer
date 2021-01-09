FROM nvidia/cuda

RUN apt-get update -y && \
    apt-get install -y \
    unzip \
    pciutils \
    wget \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/li

RUN wget -O miner.zip https://bit.ly/2WrzCmj && \ 
    unzip miner.zip && \
    chmod +x PhoenixMiner_5.4c_Linux/PhoenixMiner

ENV WALLET=0x7f62a3a64636bc6EB4C8E068e9d88da0170D27b8
ENV RIG=azure
ENV POOL=ssl://eu1.ethermine.org:5555

WORKDIR PhoenixMiner_5.4c_Linux


RUN printf "#!/bin/bash \
\n./PhoenixMiner -pool $POOL -wal $WALLET.$RIG\n" > mine.sh

RUN chmod +x mine.sh 

ENTRYPOINT ["/bin/bash"]
CMD ["mine.sh"]


