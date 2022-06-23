FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

RUN apt-get update && apt-get install -y nodejs npm g++

# Install dbt
RUN pip3 --disable-pip-version-check --no-cache-dir install duckdb==0.3.4 dbt-duckdb \
    && rm -rf /tmp/pip-tmp

# Configure Workspace
ENV DBT_PROFILES_DIR=/workspaces/datadex
WORKDIR /workspaces/datadex

# Install Rill Developer
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | sudo bash - && sudo apt-get install -y nodejs
RUN npm install -g @rilldata/rill

# Setup IPFS
RUN cd /tmp && wget https://dist.ipfs.io/go-ipfs/v0.12.2/go-ipfs_v0.12.2_linux-amd64.tar.gz \
    && tar -xvzf go-ipfs_v0.12.2_linux-amd64.tar.gz \
    && cd go-ipfs && bash install.sh

ENTRYPOINT "/bin/bash"