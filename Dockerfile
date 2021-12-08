# Setting the base OS
FROM ubuntu

# Name of Creator
LABEL Author="Panther Support"
LABEL Corporation="Prolifics Inc."

# Setting up JDK
RUN mkdir -p /Apps/ProlificsContainer
WORKDIR /Apps/ProlificsContainer
# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;
#install vim
RUN apt-get update && \
    apt-get install -y vim;



# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
ENV SMJAVALIBRARY=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/libjvm.so



# Unpacking Panther
RUN mkdir -p /Apps/ProlificsContainer/prlstdwb553.07
COPY prlstdwb553.07 /Apps/ProlificsContainer/prlstdwb553.07
     
# Unpacking Panther and creating space for logs
RUN mkdir -p /Apps/ProlificsContainer/TestPanther
COPY Debugger /Apps/ProlificsContainer/TestPanther
RUN mkdir -p /Apps/ProlificsContainer/TestPanther/error



# Setting and installing Apache Tomcat
RUN mkdir -p /Apps/ProlificsContainer/Tomcat
ENV CATALINA_HOME=/Apps/ProlificsContainer/Tomcat
COPY apache-tomcat-8.5.33 /Apps/ProlificsContainer/Tomcat

# Configuring Panther Servlet
RUN useradd -ms /bin/bash proweb
ENV HOME=/home/proweb
RUN mkdir -p ${HOME}/ini
COPY PantherDemo.war ${CATALINA_HOME}/webapps
COPY PantherDemo.ini ${HOME}/ini
RUN chmod -R 0777 /home

# Setting up environment for Panther Web
ENV SMBASE=/Apps/ProlificsContainer/prlstdwb553.07
ENV PATH=$SMBASE/util:$SMBASE/config:${CATALINA_HOME}/bin:$SMBASE/servlet:$PATH
ENV SMPATH=$SMBASE/util:$SMBASE/config
ENV SMFLIBS=$SMBASE/util/mgmt.lib:$SMBASE/util/screens.lib
ENV LM_LICENSE_FILE=$SMBASE/licenses/license.dat
ENV LD_LIBRARY_PATH=$SMBASE/lib:/usr/lib64:/lib64

# Starting the app and keeping the container running
COPY ./docker-entrypoint.sh /

# Resolving Possible permission issues
RUN chmod -R 0777 /Apps/ProlificsContainer

# Setting the landing point in the container
WORKDIR /Apps/ProlificsContainer/TestPanther

# Expose the ports
EXPOSE 8080

# Setting the user
USER proweb
ENV SMUSER=proweb

ENTRYPOINT ["/docker-entrypoint.sh"]

#Copyright © 2021 Prolifics Inc. All Rights Reserved.
