FROM klakegg/hugo:ext-pandoc

RUN apk update

COPY binder/apk.txt /tmp/
RUN apk add \
        $(cut -d# -f1 </tmp/apk.txt) && \
    rm -rf /var/lib/apt/lists/* /tmp/apk.txt

COPY binder/nde/env.sh /etc/profile.d/ade_env.sh
COPY binder/nde/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
