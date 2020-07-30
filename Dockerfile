
# No Copyright 2020, Bulat Valeev, 
#docker run -it -d -u root -p3244:22 deploy-qt5
# Use Ubuntu 16.04 LTS as the basis for the Docker image.


# docker build --no-cache --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --tag "deploy-qt5:latest" .
# docker build -t eg_sshd .

FROM ubuntu:16.04
RUN apt-get update && apt-get -y install gawk wget git-core diffstat unzip      build-essential chrpath socat cpio python python3 python3-pip python3 xz-utils debianutils iputils-ping libsdl1.2-dev xterm tar locales ssh
RUN apt-get update && apt-get -y install bison build-essential flex gperf ibgstreamer-plugins-base0.10-dev libasound2-dev libatkmm-1.6-dev libbz2-dev libcap-dev libcups2-dev libdrm-dev libegl1-mesa-dev libfontconfig1-dev libfreetype6-dev libgcrypt11-dev libglu1-mesa-dev libgstreamer0.10-dev libicu-dev libnss3-dev libpci-dev libpulse-dev libssl-dev libudev-dev libx11-dev libx11-xcb-dev libxcb-composite0 libxcb-composite0-dev libxcb-cursor-dev libxcb-cursor0 libxcb-damage0 libxcb-damage0-dev libxcb-dpms0 libxcb-dpms0-dev libxcb-dri2-0 libxcb-dri2-0-dev libxcb-dri3-0 libxcb-dri3-dev libxcb-ewmh-dev libxcb-ewmh2 libxcb-glx0 libxcb-glx0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-image0 libxcb-image0-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-present-dev libxcb-present0 libxcb-randr0 libxcb-randr0-dev libxcb-record0 libxcb-record0-dev libxcb-render-util0 libxcb-render-util0-dev libxcb-render0 libxcb-render0-dev libxcb-res0 libxcb-res0-dev libxcb-screensaver0 libxcb-screensaver0-dev libxcb-shape0 libxcb-shape0-dev libxcb-shm0 libxcb-shm0-dev libxcb-sync-dev libxcb-sync0-dev libxcb-sync1 libxcb-util-dev libxcb-util0-dev libxcb-util1 libxcb-xevie0 libxcb-xevie0-dev libxcb-xf86dri0 libxcb-xf86dri0-dev libxcb-xfixes0 libxcb-xfixes0-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xkb1 libxcb-xprint0 libxcb-xprint0-dev libxcb-xtest0 libxcb-xtest0-dev libxcb-xv0 libxcb-xv0-dev libxcb-xvmc0 libxcb-xvmc0-dev libxcb1 libxcb1-dev libxcomposite-dev libxcursor-dev libxdamage-dev libxext-dev libxfixes-dev libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxss-dev libxtst-dev perl python ruby
RUN apt-get -y install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf sudo nano vi
RUN rm /bin/sh && ln -s bash /bin/sh
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV USER_NAME deploy
ENV PROJECT qt5
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME
RUN mkdir /var/run/sshd
RUN echo 'root:qt5builder' | chpasswd
RUN echo 'deploy:qt5builder' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN mkdir /home/$USER_NAME/.ssh
RUN  touch  /home/$USER_NAME/.ssh/auhorized_keys
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2+WEprkLSdRQwiQ9Oo1YMYKRyHgSZS75NxGi4u6v7u4HzQ3DeMIFXzNg03iIoPF0AUn2GoZ13hCOtROo/9c8nLf5w4EEOrxnunCVJRddD73Z5ssuqgJmXTTtjVkMzGcw/sA4sSULuD3bjsnarNQn2VjK4tiNQ5Ppk4JsCycli5gNsHIznrEzz0QDhSc2YJpp/oQqHPnf8MdeaKE3ooY0Go//NUp9uA4MT3n4OH5NUb2BjZSO1qaj84P8TDNXbaHwiE61VWwohWukxbrp8p484YvYTI0KrSBqiQXAPDJ2R6+MxsteiTaNuxUUZrRKKZXvQERuQRLFFEuXQYeAyTEhl eleps@valeev-u" >> /home/$USER_NAME/.ssh/authorized_keys
RUN chmod 700 /home/$USER_NAME/.ssh 
RUN chmod 600 /home/$USER_NAME/.ssh/authorized_keys
RUN chmod 700 /etc/ssh/ssh_config
#USER $USER_NAME
WORKDIR /home/$USER_NAME
RUN mkdir /home/$USER_NAME/rootfs
RUN usermod -aG sudo $USER_NAME
RUN git clone https://github.com/BMValeev/qt5_docker.git
RUN git clone git://code.qt.io/qt/qt5.git 
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]




