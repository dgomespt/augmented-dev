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

## Personality Configuration (Kilo only)

`core/personality.md` contains shared defaults (preferred base images, common volumes, agent frameworks). Add its content to your `kilo.json` or project-level config.

Claude Code and OpenCode load everything they need from the installed SKILL.md files directly.

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