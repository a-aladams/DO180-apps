# This is a comment line

FROM ubi8/ubi:8.5

MAINTAINER April adams <aladams@us.ibm.com>

ARG NEXUS_VERSION=2.14.3-02

ENV NEXUS_HOME=/opt/nexus

RUN yum install -y --setopt=tsflags=nodocs java-1.8.0-openjdk-devel && \
    yum clean all -y

RUN groupadd -r nexus -f -g 1001

RUN useradd -u 1001 -r -g nexus -m -d ${NEXUS_HOME} -s /sbin/nologin -c "Nexus User" nexus
 
RUN chown -R nexus:nexus ${NEXUS_HOME}

RUN chmod -R 755 ${NEXUS_HOME}/ 

USER nexus 

ADD nexus-${NEXUS_VERSION}-bundle.tar.gz  ${NEXUS_HOME}

COPY nexus-start.sh  ${NEXUS_HOME}/

RUN ln -s ${NEXUS_HOME}/nexus-${NEXUS_VERSION} ${NEXUS_HOME}/nexus2

WORKDIR ${NEXUS_HOME}

VOLUME ["/opt/nexus/sonatype-work"]

CMD ["sh", "nexus-start.sh"]

