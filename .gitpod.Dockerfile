FROM python:3.9.9-slim

# Requirements
RUN python3 -m pip install -r https://raw.githubusercontent.com/dsbowen/hemlock-template/master/requirements.txt