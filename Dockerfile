FROM debian:latest
LABEL Author="Elvis Oliveira <elvis.olv@gmail.com>"

# Transmission Port:
EXPOSE 6901-6999

# Enviroment Dependencies:
RUN apt-get update && \
    apt-get install build-essential g++ git python libreadline6-dev libcurl4-openssl-dev -y

# Get Openkore
RUN git clone https://github.com/OpenKore/openkore.git

# Set local profiles
ADD openkore /openkore
