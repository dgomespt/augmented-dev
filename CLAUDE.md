# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

**augmented-dev** is a collection of AI agent skills following the [agentskills.io](https://agentskills.io) open standard. Skills are reusable instruction sets (as Markdown files) that can be installed into coding assistants (Claude Code, Kilo, OpenCode).

## Key Commands

```bash
# Install a skill for a specific tool
./install.sh --tool <kilo|claude|opencode> --skill <skill-name>

# List available skills
./install.sh

# In Kilo sessions
/install-skill <skill-name>
```

The installer symlinks `skills/<name>/SKILL.md` into the target tool's config directory.

## Architecture

- **`skills/`** — Each subdirectory contains a `SKILL.md` with YAML frontmatter (name, description, extends, compatibility, metadata) and the skill's rules. Skills can extend other skills (e.g., `agentic-python` extends `dockerized`).
- **`core/personality.md`** — Shared personality/configuration JSON defining preferred base images, agent frameworks, default skill, and skill hierarchy.
- **`templates/`** — Project scaffolding templates (e.g., `docker/` for multi-image project structures).
- **`.kilo/command/`** — Kilo-specific slash commands.
- **`kilo.json`** — Kilo skill path configuration (schema: `https://app.kilo.ai/config.json`).
- **`install.sh`** — Bash installer that creates symlinks from this repo into each tool's config directory.

## Skill Hierarchy

`core/personality.md` defines the hierarchy: `dockerized` is the default base skill, and other skills extend it. When a skill declares `extends: dockerized` in its frontmatter, both the base and extending skill rules apply.

## Adding a New Skill

1. Create `skills/<skill-name>/SKILL.md` with required frontmatter (name, description, compatibility, metadata with version and author)
2. Optionally declare `extends:` to inherit from a parent skill
3. Update `skills/index.md` with the new entry
4. Install via `./install.sh --tool <tool> --skill <skill-name>`
