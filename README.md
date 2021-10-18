This is an example project to run a WebObjects application inside a docker container. 

Prerequisites,

* Java 17 installed
* Maven installed
* Docker installed and configured so that you do not need to sudo to use docker

To build the project,

```
git clone git@github.com:nullterminated/wodocker.git
cd wodocker
mvn clean verify -Pdocker
```

To run the project,

```
docker run --rm -it --hostname=localhost -p 8080:8080 your.app/wodocker:latest
```

Substitute localhost for your actual domain name, as whatever hostname you specify here is used to generate complete urls.