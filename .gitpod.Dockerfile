FROM gitpod/workspace-base:latest

# Docker
# https://docs.docker.com/engine/install/ubuntu/
USER root
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" \
        | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get -y install docker-ce docker-ce-cli containerd.io

# https://github.com/rootless-containers/slirp4netns
RUN apt-get install slirp4netns

# https://docs.docker.com/compose/install/
RUN curl -o /usr/local/bin/docker-compose -fsSL https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64 \
    && chmod +x /usr/local/bin/docker-compose

# Python
# https://github.com/pyenv/pyenv#basic-github-checkout
USER gitpod
ENV PYTHON_VERSION=3.9.9
ENV PATH=$HOME/.pyenv/versions/$PYTHON_VERSION/bin:$HOME/.pyenv/bin:$PATH
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
    && pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION \
    && python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir --upgrade \
        setuptools wheel virtualenv pipenv pylint rope flake8 \
        mypy autopep8 pep8 pylama pydocstyle bandit notebook \
        twine tox coverage \
    && python3 -m pip install -r https://raw.githubusercontent.com/dsbowen/hemlock-template/master/requirements.txt \
    && sudo rm -rf /tmp/*
ENV PIP_USER=no
ENV PIPENV_VENV_IN_PROJECT=true
ENV PYTHONUSERBASE=/workspace/.pip-modules
ENV PATH=$PYTHONUSERBASE/bin:$PATH

# Heroku CLI
RUN curl https://cli-assets.heroku.com/install.sh | sh