FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y build-essential cmake git

# Clone and build Valhalla
RUN git clone --recursive https://github.com/Akashr99/Valhalla_server.git
WORKDIR /valhalla
RUN mkdir build
WORKDIR /valhalla/build
RUN cmake ..
RUN make -j$(nproc)

# Expose the Valhalla server port
EXPOSE 8002

# Start the Valhalla server
CMD ["/valhalla/build/valhalla_service", "8002"]

