install.packages(
  c(
    # VS Code R拡張機能
    "languageserver",
    "httpgd",
    # パッケージ管理
    "renv",
    "remotes",
    # ユーティリティ
    "jsonlite",

    # ---- 心理統計：混合効果モデル ----
    "lme4",       # 線形・一般化線形混合効果モデル
    "lmerTest",   # 混合効果モデルのp値（Satterthwaite法）
    "nlme",       # 非線形混合効果モデル

    # ---- 心理統計：効果量・検定力 ----
    "effectsize", # 各種効果量（Cohen's d, η², ω² 等）
    "effsize",    # Cohen's d, Cliff's delta 等
    "pwr",        # 検定力分析

    # ---- 心理統計：記述・測定 ----
    "psych",      # 心理測定全般（因子分析・信頼性等）
    "GPArotation",# 因子回転

    # ---- 心理統計：多変量解析 ----
    "MASS",       # 判別分析・多変量解析
    "car",        # ANOVA・回帰診断（Type II/III SS）
    "Hmisc",      # 統計ユーティリティ・相関行列

    # ---- 心理統計：共分散構造分析（SEM） ----
    "lavaan",     # 構造方程式モデリング
    "semPlot",    # SEM可視化
    "semTools",   # SEM補助ツール（測定不変性等）

    # ---- 心理統計：多重比較・推定周辺平均 ----
    "emmeans",    # 推定周辺平均・対比
    "multcomp",   # 一般線形仮説の多重比較

    # ---- 心理統計：ベイズ統計 ----
    "BayesFactor",# ベイズ因子
    "brms",       # ベイズ回帰（Stan ベース）
    "bayestestR", # ベイズ統計の事後分布要約

    # ---- 心理統計：欠損値処理 ----
    "mice",       # 多重代入法

    # ---- 心理ネットワーク解析 ----
    "qgraph",               # ネットワーク可視化・偏相関ネットワーク
    "bootnet",              # ネットワーク推定・ブートストラップ安定性
    "networktools",         # ネットワーク橋中心性・補助ツール
    "IsingFit",             # イジングモデル（二値データ）
    "IsingSampler",         # イジングモデルのサンプリング
    "NetworkComparisonTest",# ネットワーク比較検定（NCT）
    "EGAnet",               # 探索的グラフ分析（次元推定）
    "psychonetrics",        # 確認的ネットワークモデル
    "mgm"                   # 混合グラフィカルモデル（異なる測定尺度の混在）
  ),
  repos = "http://cran.rstudio.com/"
)

# GitHub からのインストール
remotes::install_github(
  c(
    "ykunisato/psyinfr",    # 心理情報学研究用ツール
    "dstanley4/apaTables"   # APA形式の表出力
  ),
  dependencies = TRUE
)
