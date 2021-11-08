FROM klakegg/hugo:0.88.0-ext-ubuntu

# Install basic requirements
RUN apt-get update && \
    echo 'Etc/UTC' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    software-properties-common \
    sudo locales apt-utils clang wget \
    build-essential procps curl file tzdata \
    python3-pip \
    curl \
    gnupg2 \
    sharutils \
    lsb-release \
    gettext-base \
    keyboard-configuration && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8; dpkg-reconfigure -f noninteractive locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Enable sudo for all users 
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install apt packages
COPY binder/apt.txt /tmp/
RUN apt-get update && \
    apt-get install -y \
        $(cat /tmp/apt.txt | cut -d# -f1 | envsubst) \
    && rm -rf /var/lib/apt/lists/*

# Install Python requirements
COPY binder/requirements.txt /tmp/
RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install -r /tmp/requirements.txt

COPY binder/Pipfile /tmp/
RUN cd /tmp && pip install pipenv

COPY binder/nde/env.sh /etc/profile.d/ade_env.sh
COPY binder/nde/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
