FROM mstormo/suse:11SP3
## Configure the java 1.6 environment
COPY ./jdk-6u45-linux-x64.bin /opt
RUN ./opt/jdk-6u45-linux-x64.bin && mkdir /usr/java && mv ./jdk1.6.0_45 /usr/java
ENV JAVA_HOME=/usr/java/jdk1.6.0_45 
ENV JRE_HOME=$JAVA_HOME/jre 
ENV JAVA_BIN=$JAVA_HOME/bin 
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib 
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
ENV MW_HOME=/usr/weblogic1036
## install  the weblogic server
COPY ./weblogic1036/ /usr/weblogic1036/
RUN .$MW_HOME/configure.sh && .$MW_HOME/wlserver/server/bin/setWLSEnv.sh
##  install bpm server
COPY ./winstream /opt
## the silent file for install bpm
COPY ./silent.xml /opt
RUN ./opt/Installer/setuplinux.bin -options /opt/silent.xml -silent
## start/stop bpm server 
COPY ./start.sh /usr/weblogic1036/user_projects/domains/sbm76/ 
COPY ./setupsbm.sh /usr/weblogic1036/user_projects/domains/sbm76/ 
COPY ./stop.sh /usr/weblogic1036/user_projects/domains/sbm76/ 
COPY ./license.xml /opt/SBM764/conf/license.xml 
COPY bmpatch-7.6.4.12/ /opt/SBM764/patches/bmpatch-7.6.4.12 
RUN sed -i 's/VM_ARGS="-Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=128m"/VM_ARGS="-Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=512m"/' /usr/weblogic1036/user_projects/domains/sbm76/startAdminServer.sh && \
    cd /opt/SBM764/patches/bmpatch-7.6.4.12/bin && ./setpatchenv.sh
WORKDIR /usr/weblogic1036/user_projects/domains/sbm76/
CMD ./setupsbm.sh
#ADD wsserver.sh /usr/weblogic1036/user_projects/domains/sbm76/
#ENTRYPOINT ["bash","wsserver.sh"]  
#CMD ["setup"]
