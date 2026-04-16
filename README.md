# ccp-dev-con

GitHub Codespaces 向けの開発コンテナ設定リポジトリです。R・Python・Quarto を用いたデータ分析・ドキュメント生成に特化した環境を提供します。

## 含まれる環境

| ツール | 内容 |
|---|---|
| R | `rocker/tidyverse` ベース（R + Tidyverse + Quarto プリインストール済み） |
| Python | `python3` + `pip` |
| Quarto | Rmarkdown・Jupyter との統合ドキュメント生成 |
| RStudio Server | ブラウザ上で RStudio を利用可能（ポート 8787） |

## ファイル構成

```
.
├── Dockerfile                          # コンテナイメージの定義
├── install.R                           # Rパッケージ一覧
├── requirements.txt                    # Pythonパッケージ一覧
├── .devcontainer/
│   └── devcontainer.json               # Codespaces / Dev Containers 設定
└── .github/
    └── workflows/
        └── publish-docker.yml          # GHCRへの自動ビルド・公開ワークフロー
```

## パッケージの追加・変更

### Rパッケージ

[install.R](install.R) にパッケージ名を追記します。

```r
install.packages(
  c(
    "languageserver",
    "httpgd",
    "renv",
    "jsonlite",
    "your-new-package"   # ← 追加
  ),
  repos = "http://cran.rstudio.com/"
)
```

### Pythonパッケージ

[requirements.txt](requirements.txt) にパッケージ名を追記します。

```
jupyter
pandas
numpy
matplotlib
your-new-package   # ← 追加
```

変更を `main` ブランチにプッシュすると、GitHub Actions が自動的に新しいイメージをビルドして GitHub Container Registry (GHCR) に公開します。

## GitHub Actions によるイメージ公開

`main` ブランチへのプッシュをトリガーに、以下が自動実行されます。

1. Dockerfile・install.R・requirements.txt を含むイメージをビルド
2. `ghcr.io/<owner>/ccp-dev-con:latest` タグで GHCR へプッシュ

> **初回セットアップ時の注意**
> GHCRに公開されたパッケージは、デフォルトで Private になっています。
> Codespaces から誰でも Pull できるようにするには、リポジトリの
> **Settings → Packages** から該当パッケージを **Public** に変更してください。

パッケージ関連ファイルの変更時のみワークフローを実行したい場合は、
[publish-docker.yml](.github/workflows/publish-docker.yml) の `paths` フィルターのコメントを解除してください。

```yaml
paths: ['Dockerfile', 'install.R', 'requirements.txt']
```

## Codespaces での使い方

### 1. イメージ公開前（初回）

[.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) はデフォルトでローカルの Dockerfile からビルドします。リポジトリを開いて Codespace を起動するとビルドが自動実行されます。

### 2. イメージ公開後（推奨）

ビルド済みイメージを使うと Codespace の起動が大幅に高速化されます。
[.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) を以下のように編集してください。

```json
// "build": { "dockerfile": "../Dockerfile" },  ← コメントアウト
"image": "ghcr.io/ykunisato/ccp-dev-con:latest"  // ← コメント解除
```

### 3. RStudio Server へのアクセス

Codespace 起動後、ポート **8787** をブラウザで開くと RStudio Server を利用できます。
（ユーザー名: `rstudio` / パスワード: `rstudio`）

## VS Code 拡張機能

`devcontainer.json` により以下の拡張機能が自動インストールされます。

| 拡張機能 | 用途 |
|---|---|
| REditorSupport.r | R言語サポート（補完・シンタックスハイライト） |
| RDebugger.r-debugger | Rデバッガー |
| quarto.quarto | Quartoドキュメント編集・プレビュー |
| ms-python.python | Python言語サポート |
| ms-python.vscode-pylance | 高性能な型チェック・補完 |
| ms-toolsai.jupyter | Jupyter Notebook サポート |
| eamodio.gitlens | Git履歴・blame 表示 |
| github.vscode-pull-request-github | GitHub PR・Issue 管理 |
