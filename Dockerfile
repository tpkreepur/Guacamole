FROM tomcat:9-jdk11

RUN apt-get update -qq \
	&& apt-get install -y xmlstarlet unzip\
	&& rm -rf /var/lib/apt/lists/*

# This is where the build artifacts go in the runtime image
WORKDIR /opt/guacamole

# Copy artifacts from builder image into this image
COPY client/config/ .

# Create a new user guacamole
ARG UID=1001
ARG GID=1001
RUN groupadd --gid $GID guacamole
RUN useradd --system --create-home --shell /usr/sbin/nologin --uid $UID --gid $GID guacamole

# Run with user guacamole
USER guacamole

# Start Guacamole under Tomcat, listening on 0.0.0.0:8080
EXPOSE 8080
CMD ["/opt/guacamole/bin/start.sh" ]

