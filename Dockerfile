FROM centos:7

RUN yum install -y wget tar xorg-x11-server-Xvfb firefox

ADD phantomjs-2.1.1-linux-x86_64 /phantomjs-2

RUN mkdir -p /opt/phantomjs \
  && cp -r /phantomjs-2/bin /opt/phantomjs/ \
  && ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm \
  && yum -y update \
  && yum install -y python-pip \
  && pip install --upgrade pip \
  && pip install robotframework robotframework-selenium2library requests apns \
  && mkdir -p /robots

ADD selenium-2.53.6 /selenium
WORKDIR /selenium
RUN python setup.py install

ADD run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

# BUG Firefox in Centos
RUN dbus-uuidgen >/etc/machine-id

WORKDIR /robots

CMD ["run.sh"]
