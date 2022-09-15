# See https://github.com/graphite-project/docker-graphite-statsd/releases
# for the latest release available
FROM graphiteapp/graphite-statsd:1.1.10-3
LABEL org.opencontainers.image.description "Graphite build for ARM64"

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
