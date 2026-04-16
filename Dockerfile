# R, Tidyverse, Quartoがプリインストールされたベースイメージ
FROM rocker/tidyverse:latest

# rootユーザーで必要なシステムパッケージとPythonをインストール
USER root

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    git \
    # Python C拡張のコンパイルに必要（pymc/pytensor, igraph 等）
    build-essential \
    # lme4, nlme 等のコンパイルに必要
    liblapack-dev \
    libblas-dev \
    gfortran \
    # brms (Stan) のコンパイルに必要
    libv8-dev \
    # qgraph, networktools 等のグラフィックス依存
    libglpk-dev \
    libgmp-dev \
    # psych, Hmisc 等の依存 / pycurl 等の Python パッケージ依存
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Rパッケージのインストール（install.R で管理）
COPY install.R /tmp/install.R
RUN Rscript /tmp/install.R

# Pythonパッケージのインストール（requirements.txt で管理）
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --break-system-packages -r /tmp/requirements.txt

# Codespacesで標準的に使われるユーザー（rockerでは 'rstudio' がデフォルトで存在）
USER rstudio
