# Pin OS version
FROM ubuntu:jammy

# Arguments
ARG apt_packages="autoconf automake build-essential certbot curl flex gcc hwloc libcap-dev libtool libncurses5-dev libncursesw5-dev libpcre3-dev libssl-dev libtool libxml2-dev libz-dev lua5.4 make pkg-config"
ARG ats_version=9.1.2

# Metadata
LABEL authors="brian.maher@kcl.ac.uk"

# Update & Upgrade
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y 

# Install Dependencies
RUN DEBIAN_FRONTEND=noninteractive apt install -y ${apt_packages}

# Download and extract ATS - TODO verify checksum
RUN mkdir -p /tmp/build && \
        curl -L https://downloads.apache.org/trafficserver/trafficserver-${ats_version}.tar.bz2 | tar xjvf - -C /tmp/build --strip-components 1

# Build
RUN cd /tmp/build && \
        ./configure --prefix=/opt/trafficserver && \
        make && \
        make install

# Tidy up the ATS config (this should be mounted externally - see README, however we leave this here by default to test)
RUN mv /opt/trafficserver/etc/trafficserver /etc/trafficserver && \
        ln -s /etc/trafficserver /opt/trafficserver/etc/trafficserver

# Clean up build tree
RUN rm -rf /tmp/build

# Expose required ports
EXPOSE 80
EXPOSE 443
EXPOSE 8080

# Go!
CMD ["/opt/trafficserver/bin/traffic_server"]
