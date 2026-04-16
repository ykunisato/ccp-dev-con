# R, Tidyverse, Quartoがプリインストールされたベースイメージ
FROM rocker/tidyverse:latest

# rootユーザーで必要なシステムパッケージとPythonをインストール
USER root

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    && rm -rf /var/lib/apt/lists/*

# Rパッケージのインストール（install.R で管理）
COPY install.R /tmp/install.R
RUN Rscript /tmp/install.R

# Pythonパッケージのインストール（requirements.txt で管理）
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --break-system-packages -r /tmp/requirements.txt

# Codespacesで標準的に使われるユーザー（rockerでは 'rstudio' がデフォルトで存在）
USER rstudio
