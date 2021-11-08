FROM python:3.8-slim

RUN apk update

COPY binder/apt.txt /tmp/
RUN apt-get install \
        $(cut -d# -f1 </tmp/apt.txt) && \
    rm -rf /var/lib/apt/lists/* /tmp/apt.txt

COPY binder/nde/env.sh /etc/profile.d/ade_env.sh
COPY binder/nde/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
