# See https://github.com/graphite-project/docker-graphite-statsd/releases
# for the latest release available
FROM graphiteapp/graphite-statsd:1.1.10-5

LABEL org.opencontainers.image.source=https://github.com/gdha/pi4-graphite
LABEL org.opencontainers.image.description "Graphite build for AMD64 and ARM64"
LABEL org.opencontainers.image.licenses=GPL-3.0-or-later

ENV  GRAPHITE_ADMIN_USER                            "root"
ENV  GRAPHITE_ADMIN_PWD                             "Password4u"
ENV  GRAPHITE_ADMIN_MAIL                            "fake.address@example.com"
ENV  GRAPHITE_TIME_ZONE                             "Europe/Brussels"

COPY opt/graphite/conf/carbon.conf                  /opt/graphite/conf/carbon.conf
COPY opt/graphite/conf/storage-schemas.conf         /opt/graphite/conf/storage-schemas.conf
COPY opt/graphite/bin/django_admin_init.exp         /opt/graphite/bin/django_admin_init.exp
COPY entrypoint.sh                                  /entrypoint.sh

RUN  chmod a+x                                      /entrypoint.sh \
     && chmod a+x                                   /opt/graphite/bin/django_admin_init.exp \
     && echo "Europe/Brussels" >                    /etc/timezone

ENTRYPOINT ["/entrypoint.sh"]
