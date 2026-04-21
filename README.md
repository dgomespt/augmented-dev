# Augmented Dev

AI Agent Skills for coding assistants following the [agentskills.io](https://agentskills.io) open standard.

## Skills

| Skill | Description |
|-------|-------------|
| `dockerized` | Generic Docker-first for any language |
| `agentic-python` | Python agents (extends dockerized) |

## Installation

### Kilo

```bash
./install.sh --tool kilo --skill <skill-name>
```

Or run `/install-skill <skill-name>` in any Kilo session.

### Claude Code

```bash
./install.sh --tool claude --skill <skill-name>
```

### OpenCode

```bash
./install.sh --tool opencode --skill <skill-name>
```

## Personality Configuration

Copy `core/personality.md` to your project's root to apply default settings:

### Kilo

```bash
cp core/personality.md <your-project>/RTK.md
```

Or add to your existing `RTK.md`:

```markdown
$(cat core/personality.md)
```

### Claude Code

Add to `CLAUDE.md` in your project:

```markdown
$(cat core/personality.md)
```

## Skill Hierarchy

- **default_skill**: `dockerized` (applies to all projects)
- **skill_hierarchy**: `agentic-python` extends `dockerized`

Tools load: base skill + project-specific skills.

## Project Structure

```
augmented-dev/
├── skills/           # Skill definitions
│   ├── dockerized/
│   └── agentic-python/
├── templates/        # Project scaffolding
├── core/            # Personality configuration
├── .kilo/          # Kilo commands
├── install.sh       # Installation script
└── README.md
```