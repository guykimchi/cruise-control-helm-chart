FROM openjdk:11-jdk-slim

# Set working directory
WORKDIR /opt/cruise-control

# Install required tools
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    curl \
    gradle \
    vim \
 && rm -rf /var/lib/apt/lists/*

# Download and extract Cruise Control source code (you can change the version here)
ENV CC_VERSION=3.0.3
RUN wget https://github.com/linkedin/cruise-control/archive/refs/tags/${CC_VERSION}.zip -O cruise-control.zip \
 && unzip cruise-control.zip \
 && mv cruise-control-${CC_VERSION}/* . \
 && rm -rf cruise-control-${CC_VERSION} cruise-control.zip

ENV CCFE_VERSION=0.4.0
RUN wget https://github.com/linkedin/cruise-control-ui/releases/download/v${CCFE_VERSION}/cruise-control-ui-${CCFE_VERSION}.tar.gz \
 && tar xvzf cruise-control-ui-0.4.0.tar.gz

# (Optional) Initialize a local Git repository
RUN git init \
 && git config user.email "cruisecontrol@example.com" \
 && git config user.name "CruiseControl Builder" \
 && git add . \
 && git commit -m "Init local repo." \
 && git tag -a ${CC_VERSION} -m "Init local version."

# Build Cruise Control
RUN ./gradlew jar copyDependantLibs


# Back to Cruise Control root
WORKDIR /opt/cruise-control

# Expose Cruise Control port
EXPOSE 9090

# Default start command
CMD ["./kafka-cruise-control-start.sh", "config/cruisecontrol.properties"]