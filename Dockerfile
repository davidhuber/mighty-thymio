FROM jeguzzi/ros:armhf-kinetic-ros-dev
MAINTAINER Jerome Guzzi "jerome@idsia.ch"

RUN apt-get update && apt-get install -y \
    libudev-dev \
    libxml2-dev \
    ros-kinetic-tf \
    && rm -rf /var/lib/apt/lists/*

RUN echo v2

RUN git clone --recursive https://github.com/jeguzzi/ros-aseba.git src/ros-aseba
RUN git clone https://github.com/jeguzzi/thymioid.git src/thymioid

RUN catkin config --blacklist thymio_navigation ethzasl_aseba

RUN catkin build

RUN apt-get update && apt-get install -y \
    ros-kinetic-xacro \
    ros-kinetic-robot-state-publisher \
    ros-kinetic-image-proc \
    ros-kinetic-usb-cam \
    ros-kinetic-image-transport-plugins \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    python-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip install netifaces

RUN apt-get update && apt-get install -y \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/hardkernel/wiringPi.git /tmp/wiringPi
RUN cd /tmp/wiringPi && ./build

RUN pip install wiringpi

RUN cd src/thymioid && git pull



# RUN ROS_PACKAGE_PATH=`pwd`/src/ros-aseba \
#     rosdep install --from-paths src/ros-aseba/asebaros --ignore-src --as-root=apt:false -i -y

# RUN export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:`pwd`/src/ros-aseba && rosdep update
# RUN rosdep install asebaros
#RUN catkin build
