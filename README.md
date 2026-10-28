# workbuddy-skills

WorkBuddy 技能合集。每个一级子目录是一个独立技能，目录内含 `SKILL.md`（必需）及配套脚本（可选）。

## 目录结构

```
workbuddy-skills/
├── README.md
├── _template/          # 技能模板，新增技能时复制此目录
│   └── SKILL.md
├── install.sh          # macOS / Linux / Git Bash 一键安装
├── install.ps1         # Windows PowerShell 一键安装
└── <技能名>/           # 每个技能一个目录
    └── SKILL.md
```

## 安装

### 方式一：安装脚本（推荐）

```bash
# macOS / Linux / Git Bash
./install.sh <技能名>

# Windows PowerShell
.\install.ps1 -Skill <技能名>
```

脚本行为：校验源目录存在 → 目标已存在则自动备份为 `<技能名>.bak-<时间戳>` → 复制整个目录 → 打印安装路径。

### 方式二：手动复制

```bash
git clone https://github.com/unicornand746/workbuddy-skills.git

# macOS / Linux
cp -R workbuddy-skills/<技能名> ~/.workbuddy/skills/

# Windows
xcopy /E /I workbuddy-skills\<技能名> C:\Users\<用户名>\.workbuddy\skills\<技能名>
```

安装后**重启 WorkBuddy 会话**才会加载新技能。

## 卸载

```bash
# macOS / Linux
rm -rf ~/.workbuddy/skills/<技能名>

# Windows PowerShell
Remove-Item -Recurse -Force "$env:USERPROFILE\.workbuddy\skills\<技能名>"
```

## 新增一个技能

1. 复制模板：`cp -R _template <技能名>`
2. 改 `<技能名>/SKILL.md` 的 frontmatter 与正文
3. 在本文件「技能列表」追加一行

### 命名规范

- 全小写 kebab-case，与目录名一致：`heritage-guardian-3d`、`shutiao-ai-copy`
- 不用空格、不用中文目录名
- 一个技能一个目录，不要在技能目录里嵌套另一个技能

### SKILL.md 编写规范（关键）

`description` 是技能能否被正确调用的唯一依据，必须写满三件事：

| 要素 | 说明 | 反例 |
|---|---|---|
| 做什么 | 一句话说明能力 | ~~"用于生成 3D 模型的技能"~~（空泛，匹配率低） |
| 何时用 | 用户说出什么、提到什么时触发 | 不写则几乎不会被调用 |
| 触发词 | 用户的**真实口语**，非术语 | 写"演示文稿生成"不如写"做PPT" |

其他规则：
- 用**第三人称**，不写「我」、不写「帮助用户……」
- 单个 `SKILL.md` 正文控制在 500 行内，超长内容拆到 `references/` 子文件按需读取
- 依赖能不装就不装；确需 `pip install` 时在「依赖」一节写明，让用户手动确认

## 技能列表

| 技能 | 用途 | 来源 | 状态 |
|---|---|---|---|
| `video-shotcraft` | 用镜头配方卡 + Remotion 做电影感产品宣传片 | 上游 `Vincentwei1021/video-shotcraft` | ✅ 已安装 |

### video-shotcraft

- **不复制进本仓库**：上游 66 MB（含 125 张镜头卡、音频库、模板工程），重复塞进 git 没有意义。本仓库只记录来源与安装方式。
- **安装**：`git clone https://github.com/Vincentwei1021/video-shotcraft.git` → 整个目录放到 `~/.workbuddy/skills/video-shotcraft`
- **依赖**：Node + Remotion，仅在实际渲染 `template/` 时才需要 `npm install && npx remotion render`
- **触发示例**：「用 video-shotcraft 给这个页面做宣传片」「用 Ink Press 模板做一支片」「用 `deck-deal-flyin` 镜头卡展示这个功能」
- **在线画廊**：<https://vincentwei1021.github.io/video-shotcraft/>

> 若你确实希望把整包纳入本仓库（或改为 git submodule），说一声我来改。
