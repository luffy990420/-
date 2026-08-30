#!/usr/bin/env bash
set -e

# 占位脚本：示例会写入 analytics_runs/last_run.txt 并提交回主分支
# 真实抓取/ETL 逻辑应由 Python/Node 脚本替换此处内容

echo "Starting analytics collect at $(date -u)"
mkdir -p analytics_runs
echo "last_run: $(date -u)" > analytics_runs/last_run.txt

# Commit result back to repo (uses GITHUB_TOKEN provided by Actions)
git config user.email "actions@github.com"
git config user.name "github-actions[bot]"

# add and commit (no-op if nothing changed)
if git add analytics_runs/last_run.txt && git commit -m "chore(analytics): update last run timestamp"; then
  git push origin HEAD:main
else
  echo "No changes to commit"
fi
