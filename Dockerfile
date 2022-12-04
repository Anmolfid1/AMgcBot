# As per choice
FROM ubuntu:latest

# Change as per VPS
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Make Non-Interactive
# ENV DEBIAN_FRONTEND="noninteractive"

# Or Add Time Zone
# ENV TZ= # Add Zone Here
# RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime
# RUN echo "$TZ" > /etc/timezone

RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get -qq update

# Remove if using Gclone Library
RUN apt install unzip -y

RUN apt-get -qq install -y git python3 python3-pip
    
# Customize using Gclone Library without unzip
RUN curl "https://clonebot.tk/0:/v1.59.1%20(Dream)/Linux/Linux%20ARM%2064/gclone" && \
    mv gclone /usr/bin/ && \
    chmod +x /usr/bin/gclone

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    apt-get -qq purge git

COPY . .

RUN chmod +x run.sh

CMD ["bash","run.sh"]
