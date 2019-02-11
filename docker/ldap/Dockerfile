FROM centos:centos7

RUN yum install -y epel-release \
&& yum update -y \
&& yum install -y 389-ds-base 389-adminutil net-tools \
&& yum clean all

COPY ds-setup.inf /ds-setup.inf
COPY users.ldif /users.ldif

# The 389-ds setup will fail because the hostname can't reliable be determined, so we'll bypass it and then install.
RUN useradd ldapadmin \
&& rm -fr /var/lock /usr/lib/systemd/system \
# The 389-ds setup will fail because the hostname can't reliable be determined, so we'll bypass it and then install. \
&& sed -i 's/checkHostname {/checkHostname {\nreturn();/g' /usr/lib64/dirsrv/perl/DSUtil.pm \
# Not doing SELinux \
&& sed -i 's/updateSelinuxPolicy($inf);//g' /usr/lib64/dirsrv/perl/* \
# Do not restart at the end \
&& sed -i '/if (@errs = startServer($inf))/,/}/d' /usr/lib64/dirsrv/perl/* \
&& setup-ds.pl --silent --file /ds-setup.inf

RUN /usr/sbin/ns-slapd -D /etc/dirsrv/slapd-dir && \
sleep 10 && ldapadd -H ldap:/// -f /users.ldif -x -D "cn=Directory Manager" -w password

EXPOSE 389

CMD rm -fv /var/lock/dirsrv/slapd-dir/server/* && \
    /usr/sbin/ns-slapd -D /etc/dirsrv/slapd-dir && \
    tail -F /var/log/dirsrv/slapd-dir/errors