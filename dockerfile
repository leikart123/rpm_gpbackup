FROM centos:centos7
RUN yum -y install rpm-build redhat-rpm-config make gcc git vi tar unzip rpmlint go wget && yum clean all
RUN useradd rpmbuild -u 5002 -g wheel -p rpmbuild
COPY build/build_rpm.bash /home/rpmbuild/build_rpm.bash
COPY build/gpbackup.spec /home/rpmbuild/gpbackup.spec
COPY version.txt /home/rpmbuild/versions.txt
COPY src /home/rpmbuild/src
RUN wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz
RUN sha256sum go1.13.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.13.linux-amd64.tar.gz
RUN echo "export GOPATH=/usr/local/go/bin" >> /etc/bashrc
RUN echo "export PATH="$PATH/usr/local/go/bin"" >> /etc/bashrc
USER rpmbuild
ENV HOME /home/rpmbuild
WORKDIR /home/rpmbuild
RUN mkdir -p /home/rpmbuild/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
RUN git clone https://github.com/greenplum-db/gpbackup.git gpbackup-1.20.4
RUN tar -cvf gpbackup-1.20.4.tar.gz gpbackup-1.20.4
RUN mv gpbackup-1.20.4.tar.gz /home/rpmbuild/rpmbuild/SOURCES/
RUN mv /home/rpmbuild/gpbackup.spec /home/rpmbuild/rpmbuild/SPECS/
RUN echo '%_topdir %{getenv:HOME}/rpmbuild' > /home/rpmbuild/.rpmmacros
RUN echo '%_tmppath /home/rpmbuild/rpm/tmp' >> /home/rpmbuild/.rpmmacros