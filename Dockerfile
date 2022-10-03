FROM rockylinux:8
ENV container docker
#RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
#systemd-tmpfiles-setup.service ] || rm -f $i; done); \
#rm -f /lib/systemd/system/multi-user.target.wants/*;\
#rm -f /etc/systemd/system/*.wants/*;\
#rm -f /lib/systemd/system/local-fs.target.wants/*; \
#rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
#rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
#rm -f /lib/systemd/system/basic.target.wants/*;\
#rm -f /lib/systemd/system/anaconda.target.wants/*;
COPY spool.tar.gz /var/
RUN dnf install epel-release -y
RUN dnf install postfix dovecot opendkim -y
COPY mailpod-entrypoint /usr/local/bin
COPY mailpod-entrypoint.service /etc/systemd/system/
RUN systemctl enable mailpod-entrypoint.service
VOLUME [ "/sys/fs/cgroup" ]
#ENTRYPOINT ["/usr/sbin/mailpod-entrypoint"]
CMD ["/usr/sbin/init"]

