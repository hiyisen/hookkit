# hookkit

一组通用的 Git hooks:提交信息规范、禁提文件、分支保护。零依赖、纯 POSIX sh,Windows 可用(Git Bash)。

## 安装

```sh
cp -R hookkit/. /path/to/你的仓库/
cd /path/to/你的仓库 && sh install.sh
```

`install.sh` 设置 `core.hooksPath`、加执行权限、按需生成 `.githooks.conf` 模板。

## 自带检查

| Hook | 检查 |
|---|---|
| commit-msg | `<类型>(<范围>): <描述>`,类型表可配;merge 放行 |
| pre-commit | 行尾空白;`.DS_Store`/`Thumbs.db`/`.env*`(放行 `.env.example`);空 Markdown;可挂项目特有检查 |
| pre-push | 分支命名 `main|master|develop` 或 `<前缀>/<名称>`;禁止 `main`/`master` 直推 |

## 配置

仓库根 `.githooks.conf`(可选,不写用默认值),例如 8D 风格:

```sh
require_lang=zh        # 描述必须含中文
require_scope=1        # scope 必填
```

可配项见 `.githooks/hooks.sh` 顶部:类型表、分支前缀、禁提文件、额外检查 `extra_checks` 等。
临时跳过:`SKIP=pre-commit`(兼容 pre-commit 框架的逗号分隔)。

## Windows

- 用 Git Bash 操作,cmd/PowerShell 不行;
- `.gitattributes` 已把脚本钉死为 LF,防止 CRLF 弄坏 sh;
- 无需 `chmod`,git 靠 shebang 用自带 sh 执行。

规则实现均为单一真源,可在 CI 里复用同一个检查脚本。
