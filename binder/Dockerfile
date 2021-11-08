FROM klakegg/hugo:ext-pandoc

RUN apk update

COPY apt-packages /tmp/
RUN apk add \
        $(cut -d# -f1 </tmp/apt-packages) && \
    rm -rf /var/lib/apt/lists/* /tmp/apt-packages

COPY env.sh /etc/profile.d/ade_env.sh
COPY entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
