FROM debian:latest
LABEL Author="Elvis Oliveira <elvis.olv@gmail.com>"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Bot Port:
EXPOSE 6900-6999

# Enviroment Dependencies:
RUN apt-get update && \
    apt-get install build-essential g++ git python libreadline6-dev libcurl4-openssl-dev tmux -y

# Get Openkore
RUN git clone https://github.com/OpenKore/openkore.git

# Base Path
WORKDIR /openkore

# Compile
RUN make

# Run
CMD ["./openkore.sh"]
