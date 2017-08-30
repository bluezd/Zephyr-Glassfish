# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 
# Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
# 
# GlassFish on Docker with Oracle Linux and OpenJDK
FROM oracle/serverjre:8

# Maintainer
MAINTAINER Arindam Bandyopadhyay<arindam.bandyopadhyay@oracle.com>

# Set environment variables and default password for user 'admin'
ENV GLASSFISH_PKG=glassfish-4.1.2.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/4.1.2/release/glassfish-4.1.2.zip \
    #JavaAppPath=/employee-service.war \
    GLASSFISH_HOME=/glassfish4 \
    MD5=9a37928ea6e54334101b8a89e03a8d7d \
    PATH=$PATH:/glassfish4/bin

# Install packages, download and extract GlassFish
# Setup password file
# Enable DAS
#RUN yum -y install unzip ping mysql java-1.7.0-openjdk-devel && \
RUN yum -y install unzip iptables postgresql util-linux iputils sudo net-tools && \
    curl -O $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG && \
    rm -f $GLASSFISH_PKG && \
    yum -y remove unzip && \
    yum clean all

COPY docker-entrypoint.sh /entrypoint.sh
#COPY $JavaAppPath /$JavaAppPath
COPY start-domain.sh /start-domain.sh
COPY setupDB-postgres.sh /setupDB-postgres.sh
COPY lib/org.eclipse.persistence.moxy.jar $GLASSFISH_HOME/glassfish/modules
COPY lib /projectLib

# Ports being exposed
EXPOSE 4848 8080 8181
ENTRYPOINT ["/entrypoint.sh"]