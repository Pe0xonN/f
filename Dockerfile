FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y ca-certificates tzdata wget tar curl

WORKDIR /app
COPY . .
RUN chmod -R 777 /app 

## Teldrive
RUN --mount=type=secret,id=gist_teldrive,mode=0444,required=true \
    wget https://github.com/divyam234/teldrive/releases/latest/download/teldrive_linux_amd64.tar.gz -O /app/teldrive.tar.gz && \
    tar xvf /app/teldrive.tar.gz -C /app  && \
    wget $(cat /run/secrets/gist_teldrive) -O /app/teldrive.env && \
    chmod a+x /app/teldrive && chmod 777 /app/teldrive.env  && \
    touch /app/teldrive.db && \
    chmod 777 /app/teldrive.db

## Start
RUN chmod a+x /app/start.sh

CMD ["./start.sh"]