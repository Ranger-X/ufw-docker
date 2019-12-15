FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-transport-https \
               ca-certificates curl software-properties-common gnupg2 \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian \
                          $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y --no-install-recommends ufw "docker-ce=5:19.03*" "docker-ce-cli=5:19.03*" containerd.io \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD ufw-docker docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]

CMD ["start"]
