# Augmented Dev

AI Agent Skills for coding assistants following the agentskills.io open standard.

## Project Structure

```
augmented-dev/
├── skills/           # Skill definitions (SKILL.md)
├── templates/         # Project scaffolding templates
├── .kilo/           # Kilo-specific config
│   ├── command/    # /install-skill command
│   └── agent/       # Custom agents (future)
├── core/            # Shared configuration
├── install.sh       # Installation script
├── kilo.json        # Kilo skill configuration
└── AGENTS.md        # This file
```

## Skills

| Skill | Description |
|-------|-------------|
| `dockerized` | Generic Docker-first for any language |
| `agentic-python` | Python agents (extends dockerized) |

## Installation

### Kilo

```bash
./install.sh --tool kilo --skill agentic-python
```

This creates a symlink: `.kilo/skills/agentic-python/SKILL.md`

### Claude Code

```bash
./install.sh --tool claude --skill agentic-python
```

### OpenCode

```bash
./install.sh --tool opencode --skill agentic-python
```

## Local Development

Kilo loads skills from `kilo.json`:

```json
{
  "skills": {
    "paths": ["skills/agentic-python-dockerfirst"]
  }
}
```

Run `/install-skill <skill-name>` in any Kilo session to install a skill.

### Skill Hierarchy

Core personality defines defaults:
- **default_skill**: `dockerized` (applies to all projects)
- **skill_hierarchy**: `agentic-python` extends `dockerized`

Tools load: base skill + project-specific skills.