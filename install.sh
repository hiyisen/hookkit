#!/bin/sh
# hookkit 安装: 在仓库根执行  sh install.sh  即可启用(无需任何其他安装)
set -eu
root=${1:-$(git rev-parse --show-toplevel 2>/dev/null || echo .)}
cd "$root" || exit 1
[ -d .githooks ] || { echo "没找到 .githooks/ 目录(install.sh 应与它同目录)"; exit 1; }
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit .githooks/commit-msg .githooks/pre-push 2>/dev/null || true
[ -f .githooks.conf ] && echo "已存在 .githooks.conf,跳过生成" || {
  cat > .githooks.conf <<'EOF'
# hookkit 配置:按需取消注释;不写则全部用默认值(见 .githooks/hooks.sh 顶部)
# commit_types='feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert'
# require_scope=1                 # 1=scope 必填(8D 风格)
# require_lang=zh                 # any|zh|en ; zh=描述必须含中文
# branch_protected='main master develop'
# branch_prefixes='feature fix chore release hotfix test'
# no_push='main master'
# forbidden_pattern='(^|/)(\.DS_Store|Thumbs\.db|\.env$|\.env\.[^/]+|.+\.local)$'
# extra_checks='scripts/check-links.sh scripts/check-evidence.sh'
# skip='pre-commit'
EOF
  echo "已生成 .githooks.conf(按需编辑)"
}
echo "已启用: $root/.githooks"
