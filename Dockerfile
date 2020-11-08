#TARGET_REPO=kanedafromparis && docker build -t $TARGET_REPO/prez-fabric8-dmp:v0.1.3 . -f Dockerfile


FROM adoptopenjdk:11-jre-hotspot

ARG argGroupeId
#=defaultValue
ARG argArtifactId
#=prez-fabric8-dmp
ARG ARG_VERSION=0.1.7-SNAPSHOT

ENV JVM_OPTIONS="-Djava.security.egd=file:/dev/./urandom \
                 -XshowSettings:vm"

RUN mkdir -p /opt/prez-fabric8-dmp/conf/

COPY maven/target/prez-fabric8-dmp-${ARG_VERSION}.jar /opt/prez-fabric8-dmp/prez-fabric8-dmp.jar
USER 1001
WORKDIR /opt/prez-fabric8-dmp
ENTRYPOINT java $JVM_OPTIONS \
              -jar /opt/prez-fabric8-dmp/prez-fabric8-dmp.jar