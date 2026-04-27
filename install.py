"""
requirements.txt を1行ずつ読み込み、パッケージを個別にインストールする。
コメント・空行はスキップ。失敗したパッケージをまとめて報告してスクリプトを終了する。
"""
import subprocess
import sys

REQUIREMENTS_FILE = "/tmp/requirements.txt"

with open(REQUIREMENTS_FILE) as f:
    lines = f.readlines()

packages = []
for line in lines:
    # インラインコメントと前後の空白を除去
    pkg = line.split("#")[0].strip()
    if pkg:
        packages.append(pkg)

failed = []
for pkg in packages:
    print(f"==> Installing: {pkg}", flush=True)
    result = subprocess.run(
        [sys.executable, "-m", "pip", "install", "--no-cache-dir", pkg],
        capture_output=False,
    )
    if result.returncode != 0:
        print(f"FAILED: {pkg}", flush=True)
        failed.append(pkg)

if failed:
    print("\nThe following packages failed to install:")
    for pkg in failed:
        print(f"  {pkg}")
    sys.exit(1)

print("\nAll packages installed successfully.")
