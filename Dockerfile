#TARGET_REPO=kanedafromparis && docker build -t $TARGET_REPO/prez-fabric8-dmp:v0.1.3 . -f Dockerfile


FROM adoptopenjdk:11-jre-hotspot


ENV JVM_OPTIONS="-Djava.security.egd=file:/dev/./urandom \
                 -XshowSettings:vm"

RUN mkdir -p /opt/prez-fabric8-dmp/conf/
COPY src/main/resources/application.mariadb.compose.properties /opt/prez-fabric8-dmp/conf/application.properties

COPY target/prez-fabric8-dmp-0.1.3-SNAPSHOT.jar /opt/prez-fabric8-dmp/prez-fabric8-dmp.jar
USER 1001
WORKDIR /opt/prez-fabric8-dmp
ENTRYPOINT java $JVM_OPTIONS \
                  -Dspring.config.location=/opt/prez-fabric8-dmp/conf/application.properties \
                                        -jar /opt/prez-fabric8-dmp/prez-fabric8-dmp.jar
