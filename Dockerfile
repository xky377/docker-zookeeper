FROM centos:latest

#下载一些工具
RUN yum -y install wget
RUN yum -y install setup
RUN yum -y install perl
RUN yum -y install vim

#安装jdk和zookeeper压缩包,解压zookeeper压缩包
RUN yum -y install java-1.8.0-openjdk
RUN curl -O https://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz
RUN tar -zvxf zookeeper-3.4.14.tar.gz 
RUN mv zookeeper-3.4.14 zookeeper
RUN cd zookeeper/

#配置zookeeper
RUN mkdir zookeeper/data
RUN cd zookeeper/data/
RUN touch zookeeper/data/myid
RUN cp -r zookeeper /usr/local/
RUN mv /usr/local/zookeeper/conf/zoo_sample.cfg /usr/local/zookeeper/conf/zoo.cfg
RUN sed -i "s/dataDir=\/tmp\/zookeeper/dataDir=\/usr\/local\/zookeeper\/data/g" /usr/local/zookeeper/conf/zoo.cfg

#添加zookeeper环境变量并使其生效
RUN echo export ZOOKEEPER_HOME=/usr/local/zookeeper >> /etc/profile
RUN echo export PATH=\$PATH:\$ZOOKEEPER_HOME/bin >> /etc/profile
RUN source /etc/profile



