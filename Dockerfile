# Build with something like
# docker build --build-arg projname=wodocker --build-arg version=0.0.1-SNAPSHOT -t wodocker:0.0.1-SNAPSHOT -t wodocker:latest .
# Run with something like
# docker run -it -p 8080:8080 --rm wodocker
FROM openjdk:16-slim
ARG version
ARG projname
ENV NEXT_ROOT=/
ENV exec=/opt/woapps/${projname}.woa/${projname}
RUN mkdir -p /opt/woapps/; \
	useradd appserver;
ADD target/${projname}-${version}.woa /opt/woapps/${projname}.woa
RUN sed -i -e 's:# JVMOptions       == :# JVMOptions       == --add-exports java.base/sun.security.action=ALL-UNNAMED:g' /opt/woapps/${projname}.woa/Contents/UNIX/UNIXClassPath.txt; \
    chown -R appserver /opt/woapps;
USER appserver
EXPOSE 8080
ENTRYPOINT ${exec} -DWOPort=8080 -DWOAllowRapidTurnaround=true -DWODirectConnectEnabled=true -DWOAllowsConcurrentRequestHandling=true