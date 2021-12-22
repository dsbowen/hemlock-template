FROM gitpod/workspace-full:latest

# Python
USER gitpod
ENV PYTHON_VERSION=3.9.7
RUN pyenv install ${PYTHON_VERSION} \
    && pyenv global ${PYTHON_VERSION} \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install -r https://raw.githubusercontent.com/dsbowen/hemlock-template/master/requirements.txt

# Heroku CLI
RUN curl https://cli-assets.heroku.com/install.sh | sh