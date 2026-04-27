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
    # qgraph, networktools 等のグラフィックス依存
    libglpk-dev \
    libgmp-dev \
    # psych, Hmisc 等の依存 / pycurl 等の Python パッケージ依存
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    # httpgd の描画バックエンドに必要（Cairo + PNG）
    libcairo2-dev \
    libpng-dev \
    # pymc/pytensor, jax 等のビルドに必要
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Rパッケージのインストール（install.R で管理）
COPY install.R /tmp/install.R
RUN Rscript /tmp/install.R

# Python仮想環境を作成してパッケージをインストール（PEP 668 の制限を回避）
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade --no-cache-dir pip

COPY requirements.txt /tmp/requirements.txt
COPY install.py /tmp/install.py
RUN /opt/venv/bin/python /tmp/install.py

# 仮想環境を常に優先するようにパスを設定
ENV PATH="/opt/venv/bin:$PATH"

# Codespacesで標準的に使われるユーザー（rockerでは 'rstudio' がデフォルトで存在）
USER rstudio
